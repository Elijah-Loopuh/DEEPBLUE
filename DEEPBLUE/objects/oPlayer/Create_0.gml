
id.depth = 750;

angleStore = 0;


vectVelocity = [0, 0]; //tracks 2d Velocity
vectMoveInput = [0, 0]; //tracks 2d inputs


regularGrip = 1.25; //regular grip
sprintGrip = 1.0; //lower grip for sprinting
grip = regularGrip; //rate of change of vectVelocity axis under normal conditions

regularSpeedCap = 25;
sprintSpeedCap = 40;
speedCap = regularSpeedCap; //tracks current speed cap

snapSpeed = 0.5;


dragStatic = 0.15; //drag when no buttons held
dragDynamic = 0.0;//drag when movement buttons are held
drag = dragStatic; //fraction d/1 of speed lost every frame


dashPower = 35; //dash speed
dashCooldownMaster = 60*0.5; //# of frames between dashes
dashCooldown = dashCooldownMaster; //tracker for cooldown
dashDurationMaster = 60*0.25;
dashDuration = 0;

updateVars = function() //updates variables
{
	underSpeed = oGlobalData.vectLength(vectVelocity) <= speedCap; //tracks if player has control of the mech
	keyW = keyboard_check( ord("W") );
	keyA = keyboard_check( ord("A") );
	keyS = keyboard_check( ord("S") );
	keyD = keyboard_check( ord("D") );
	keySpace = keyboard_check( vk_space );
	keySpacePressed = keyboard_check_pressed( vk_space );
	keyShift = keyboard_check( vk_shift );
	keyMove = keyW || keyA || keyS || keyD || keySpace;
}

updateVectorMoveInput = function ()
{
	if (keyW) //accelerate
	{
		vectMoveInput[1] = -1;
	}
	else if (keyS) //accelerate
	{
		vectMoveInput[1] = 1;
	}
	else
	{
		vectMoveInput[1] = 0;
	}

	if (keyA) //accelerate
	{
		vectMoveInput[0] = -1;
	}
	else if (keyD)
	{
		vectMoveInput[0] = 1;
	}
	else
	{
		vectMoveInput[0] = 0;
	}
	
	vectMoveInput = oGlobalData.vectClamp(vectMoveInput, 1); //caps the vector to a unit circle
}

updateVelocityVector = function()
{
	if (underSpeed) //take away control when over speedCap
	{
		vectVelocity = oGlobalData.vectSum(vectVelocity, vectMoveInput); //modifies velocity with move input
		vectVelocity = oGlobalData.vectMax(vectVelocity, speedCap); //cap speed under normal circumstances
	}
}

applyDrag = function() //drag is proportional to velocity, soft caps at drag/grip. applys drag to velocity, and snaps velocity to 0 when below snapSpeed
{
	if (keyMove && underSpeed) //low grip when move inputs allowed
	{
		drag = dragDynamic;
	}
	else //high drag when no input allowed
	{
		drag = dragStatic;
	}
	
	vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectInvert(oGlobalData.vectScale(vectVelocity, drag)));
	if (oGlobalData.vectLength(vectVelocity) < snapSpeed)
	{
		vectVelocity[0] = 0;
		vectVelocity[1] = 0;
	}
}

setAngle = function()
{
	angleStore = image_angle;
	if (oGlobalData.vectAngle(vectVelocity))
	{
		image_angle = -oGlobalData.vectAngle(vectVelocity);
	}
	if (checkCollision() != 0)
	{
		image_angle = angleStore;
	}
}

checkCollision = function() //checks for collisions without actually handling them. 0 = none, 1 = x axis, 2 = y axis, 3 = both axes.
{
	wallcheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
	wallcheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
	output = 0;
	if (wallcheckX != noone)
	{
		output += 1;
	}
	if (wallcheckY != noone)
	{
		output += 2;
	}
	return output;
}

handleCollisionNew = function() //snaps to walls and stops moving, also overrides player rotation
{	
	if (checkCollision() == 1) //x axis collsion
	{
		if (vectVelocity[1] > 0) //turn to slide on wall
		{
			image_angle = 270;
		}
		if (vectVelocity[1] < 0) 
		{
			image_angle = 90;
		}
		
		if (checkCollision() == 1) //do collisions
		{
			wallcheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
			if (wallcheckX.x > x) //set scoot distance
			{
				snapX = wallcheckX.bbox_left - bbox_right;
			}
			if (wallcheckX.x < x)
			{
				snapX = wallcheckX.bbox_right - bbox_left;
			}
		
			x += snapX; //scoot to wall
			vectVelocity[0] = 0; //stop moving
		}
	}
	
	if (checkCollision() == 2) //y axis collsion
	{
		if (vectVelocity[0] > 0) //turn to slide wall
		{
			image_angle = 0;
		}
		if (vectVelocity[0] < 0)
		{
			image_angle = 180;
		}
		
		if (checkCollision() == 2) //do collisions
		{
			wallcheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
			if (wallcheckY.y > y) //set scoot distance
			{
				snapY = wallcheckY.bbox_top - bbox_bottom;
			}
			if (wallcheckY.y < y)
			{
				snapY = wallcheckY.bbox_bottom - bbox_top;
			}
		
			y += snapY; //scoot to wall
			vectVelocity[1] = 0; //stop moving
		}
	}
	
	if (checkCollision() == 3)
	{
		vectVelocity[0] = 0; //stop moving
		vectVelocity[1] = 0; 
	}
}

handleCollision = function() //deprecated, do not use
{
	wallcheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
	wallcheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
	if (wallcheckX != noone)
	{
		if (vectVelocity[1] > 0) //face upwards
		{
			image_angle = 270;
		}
		if (vectVelocity[1] < 0) //face downwards
		{
			image_angle = 90;
		}
		
		if (wallcheckX.x > x) //set scoot distance
		{
			snapX = wallcheckX.bbox_left - bbox_right;
		}
		if (wallcheckX.x < x)
		{
			snapX = wallcheckX.bbox_right - bbox_left;
		}
		
		x += snapX; //scoot to wall
		vectVelocity[0] = 0; //stop moving
	}
	if (wallcheckY != noone)
	{
		if (vectVelocity[0] > 0) //face right
		{
			image_angle = 0;
		}
		if (vectVelocity[0] < 0) //face left
		{
			image_angle = 180;
		}
		
		if (wallcheckY.y > y) //set scoot distance
		{
			snapY = wallcheckY.bbox_top - bbox_bottom;
		}
		if (wallcheckY.y < y)
		{
			snapY = wallcheckY.bbox_bottom - bbox_top;
		}
		
		y += snapY; //scoot to wall
		vectVelocity[1] = 0; //stop moving
	}
}

handleDash = function()
{
	if (keySpacePressed && dashCooldown <= 0) //activate dash
	{
		vectDashVeclocity = oGlobalData.vectScale(vectMoveInput, dashPower);
		dashDuration = dashDurationMaster;
	}
	if (dashDuration > 0) //apply dash to velocity
	{
		vectVelocity = vectDashVeclocity;
		dashDuration -= 1
	}
	if (dashCooldown >= 0) //track cooldown
	{
		dashCooldown -= 1;
	}
}

handleSprint = function()
{
	if (keyShift)
	{
		grip = sprintGrip;
		speedCap = sprintSpeedCap;
	}
	else
	{
		grip = regularGrip;
		speedCap = regularSpeedCap;
	}
}

move = function() //moves on x & y axes
{
	x += vectVelocity[0];
	y += vectVelocity[1];
}