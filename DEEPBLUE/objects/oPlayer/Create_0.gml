

vectVelocity = [0, 0]; //tracks 2d Velocity
vectMoveInput = [0, 0]; //tracks 2d inputs

grip = 1.0; //rate of change of vectVelocity axis under normal conditions
topSpeed = 25;
drag = 0.15; //fraction of speed lost every frame no inputs are held

checkKeys = function() //updates key inputs
{
	keyW = keyboard_check( ord("W") );
	keyA = keyboard_check( ord("A") );
	keyS = keyboard_check( ord("S") );
	keyD = keyboard_check( ord("D") );
	keySpace = keyboard_check( vk_space );
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
	
	vectMoveInput = oGlobalData.vectClamp(vectMoveInput, grip); //caps the vector to a circle with radius of grip
}

updateVelocityVector = function()
{
	vectVelocity = oGlobalData.vectSum(vectVelocity, vectMoveInput); //updates with input vector
	vectVelocity = oGlobalData.vectMax(vectVelocity, topSpeed); //cap speed to a max value
}

applyDrag = function() //drag is proportional to velocity, soft caps at drag/grip
{
	vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectInvert(oGlobalData.vectScale(vectVelocity, drag)));
}

setAngle = function()
{
	if (oGlobalData.vectAngle(vectVelocity) != -1)
	{
		image_angle = - oGlobalData.vectAngle(vectVelocity);
	}
}

move = function() //handles collisions and moves on both axis
{
	wallcheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
	wallcheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
	if (wallcheckX != noone)
	{
		if (wallcheckX.x > x)
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
		if (wallcheckY.y > y)
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
	x += vectVelocity[0];
	y += vectVelocity[1];
}