
id.depth = 750;

angleStore = 0;

vectVelocity = [0, 0]; //tracks 2d Velocity
vectMoveInput = [0, 0]; //tracks 2d inputs

grip = 1.0; //rate of change of vectVelocity axis under normal conditions
topSpeed = 25;
snapSpeed = 0.5;

dragStatic = 0.15; //drag when no buttons held
dragDynamic = 0.0 //drag when movement buttons are held
dragOverSpeed = 0.5; //drag applied when player is over top speed
drag = 0.15; //fraction of speed lost every frame no inputs are held


dashPower = 50; //dash speed
dashCooldownMaster = 60*0.5; //# of frames between dashes
dashCooldown = dashCooldownMaster; //tracker for cooldown

checkKeys = function() //updates key inputs
{
	keyW = keyboard_check( ord("W") );
	keyA = keyboard_check( ord("A") );
	keyS = keyboard_check( ord("S") );
	keyD = keyboard_check( ord("D") );
	keySpace = keyboard_check( vk_space );
	keySpacePressed = keyboard_check_pressed( vk_space );
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
	vectVelocity = oGlobalData.vectSum(vectVelocity, vectMoveInput); //modifies velocity with move input
	vectVelocity = oGlobalData.vectMax(vectVelocity, topSpeed); //cap speed to a max value
}

applyDrag = function() //drag is proportional to velocity, soft caps at drag/grip. applys drag to velocity, and snaps velocity to 0 when below snapSpeed
{
	if (!keyMove)
	{
		vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectInvert(oGlobalData.vectScale(vectVelocity, drag)));
		if (oGlobalData.vectLength(vectVelocity) < snapSpeed)
		{
			vectVelocity[0] = 0;
			vectVelocity[1] = 0;
		}
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

handleCollision = function() //snaps to walls and stops moving, also overrides player rotation
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
	vectVelocity = oGlobalData.vectScale(vectMoveInput, dashPower);
}

move = function() //moves on x & y axes
{
	x += vectVelocity[0];
	y += vectVelocity[1];
}