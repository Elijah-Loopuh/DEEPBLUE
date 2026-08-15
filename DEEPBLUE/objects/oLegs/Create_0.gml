
id.depth = 750;
/*
//variable initalization
regularGrip = 0; //regular grip
sprintGrip = 0; //lower grip for sprinting
regularSpeedCap = 0;
sprintSpeedCap = 0;
dragStatic = 0; //drag when no buttons held
dragDynamic = 0;//drag when movement buttons are held
dashPower = 0; //dash speed
dashCooldownMaster = 0; //# of frames between dashes
dashDurationMaster = 0;

//oGlobalData.initalizePlayerLegs(oGlobalData.equippedLegs);
*/
sprite_index = sprite;
angleStore = 0;
snapSpeed = 0.5; //threshold to snap to a speed value
dashDuration = 0;
vectVelocity = [0, 0]; //tracks 2d Velocity
vectMoveInput = [0, 0]; //tracks 2d inputs
vectPos = [x, y]; //tracks position

//variable assigning
grip = regularGrip; //rate of change of vectVelocity axis under normal conditions
speedCap = regularSpeedCap; //tracks current speed cap
drag = dragStatic; //fraction d/1 of speed lost every 
dashCooldown = dashCooldownMaster;
animationSpeed = 1/45; //multiplier from vectVelocity scale to animation fps



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

updateVectVelocity = function() //handles move input & drag application
{
	underSpeed = oGlobalData.vectLength(vectVelocity) <= speedCap; //tracks if player has control of the mech
	if (keyMove && underSpeed) //low grip when move inputs allowed
	{
		drag = dragDynamic;
		vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectScale(vectMoveInput, grip)); //modifies velocity with move input
		vectVelocity = oGlobalData.vectMax(vectVelocity, speedCap); //cap speed under normal circumstances
	}
	else //high drag when no input allowed
	{
		drag = dragStatic;
	}
	
	vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectInvert(oGlobalData.vectScale(vectVelocity, drag)));
	if (oGlobalData.vectLength(vectVelocity) < snapSpeed)
	{
		vectVelocity = oGlobalData.vectZero;
	}
	
	if (abs(oGlobalData.vectLength(vectVelocity) - speedCap) < snapSpeed && false)
	{
		vectVelocity = oGlobalData.vectMax(vectVelocity, speedCap); //snap to speed cap to prevent fluttering
		show_debug_message("oLegs, vectVelocity snapped");
	}
}

setAngle = function(angleTarget = -oGlobalData.vectAngle(vectVelocity))
{
	angleStore = image_angle;
	if (oGlobalData.vectAngle(vectVelocity) != -1) //valid angle target
	{
		image_angle = angleTarget;
	}
	if (checkCollision() != 0) //if turn would put inside wall, reset
	{
		image_angle = angleStore;
	}
}

checkCollision = function() //checks for collisions without actually handling them. 0 = none, 1 = x axis, 2 = y axis, 3 = both axes.
{
	wallCheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
	wallCheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
	output = 0;
	if (wallCheckX != noone)
	{
		output += 1;
	}
	if (wallCheckY != noone)
	{
		output += 2;
	}
	return output;
}

handleCollisionNew = function() //snaps to walls and stops moving, also overrides player rotation
{	
	if (checkCollision() == 1 && checkCollision() != 3 ) //x axis collsion
	{
		if (vectVelocity[1] > 0) //turn to slide on wall
		{
			setAngle(270);
		}
		if (vectVelocity[1] < 0) 
		{
			setAngle(90);
		}
		
		if (checkCollision() == 1) //do collisions
		{
			wallCheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
			if (wallCheckX.x > x) //set scoot distance
			{
				snapX = wallCheckX.bbox_left - bbox_right;
			}
			if (wallCheckX.x < x)
			{
				snapX = wallCheckX.bbox_right - bbox_left;
			}
		
			x += snapX; //scoot to wall
			vectVelocity[0] = 0; //stop moving
		}
	}
	
	if (checkCollision() == 2 && checkCollision() != 3 ) //y axis collsion
	{
		if (vectVelocity[0] > 0) //turn to slide wall
		{
			setAngle(0);
		}
		if (vectVelocity[0] < 0)
		{
			setAngle(180);
		}
		
		if (checkCollision() == 2) //do collisions
		{
			wallCheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
			if (wallCheckY.y > y) //set scoot distance
			{
				snapY = wallCheckY.bbox_top - bbox_bottom;
			}
			if (wallCheckY.y < y)
			{
				snapY = wallCheckY.bbox_bottom - bbox_top;
			}
		
			y += snapY; //scoot to wall
			vectVelocity[1] = 0; //stop moving
		}
	}
	
	if (checkCollision() == 3)
	{
		vectVelocity[0] = 0;
		vectVelocity[1] = 0;
	}
	
	wallCheck = instance_place(x, y, oGlobalData.collisionList);
	
	if (wallCheck != noone) //if inside wall, push outside of the wal
	{
		if (wallCheck.x + 32 > x)
		{
			x += wallCheck.bbox_left - bbox_right;
			vectVelocity[0] = -5;
			//show_debug_message("pushout to left");
		}
		if (wallCheck.x + 32 < x)
		{
			x += wallCheck.bbox_right - bbox_left;
			vectVelocity[0] = 5;
			//show_debug_message("pushout to right");
		}
		if (wallCheck.y + 32 > y)
		{
			y += wallCheck.bbox_top - bbox_bottom;
			vectVelocity[1] = -5;
			//show_debug_message("pushout to top");
		}
		if (wallCheck.y + 32 < y)
		{
			y += wallCheck.bbox_bottom - bbox_top;
			vectVelocity[1] = 5;
			//show_debug_message("pushout to bottom");
		}
		//show_debug_message(vectVelocity[0]);
		//show_debug_message(vectVelocity[1]);
	}
}

handleDash = function()
{
	if (keySpacePressed && dashCooldown <= 0) //activate dash
	{
		vectDashVeclocity = oGlobalData.vectScale(vectMoveInput, dashPower);
		dashDuration = dashDurationMaster;
		dashCooldown = dashCooldownMaster;
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

handleAnimation = function()
{
	image_speed = oGlobalData.vectLength(vectVelocity) * animationSpeed;
	if (oGlobalData.vectLength(vectVelocity) == 0)
	{
		image_index = 0;
	}
}

move = function() //moves on x & y axes
{
	x += vectVelocity[0];
	y += vectVelocity[1];
}
