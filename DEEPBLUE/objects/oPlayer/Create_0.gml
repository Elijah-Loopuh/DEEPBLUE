

vectVelocity = [0, 0]; //tracks 2d Velocity
vectMoveInput = [0, 0]; //tracks 2d inputs

grip = 1.0; //rate of change of vectVelocity axis under normal conditions
topSpeed = 10;
drag = 0.25; //fraction of speed lost every frame no inputs are held

checkKeys = function() //updates key inputs
{
	keyW = keyboard_check( ord("W") );
	keyA = keyboard_check( ord("A") );
	keyS = keyboard_check( ord("S") );
	keyD = keyboard_check( ord("D") );
	keyMove = keyW || keyA || keyS || keyD;
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
}

applyDrag = function()
{
	vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectInvert(oGlobalData.vectScale(vectVelocity, drag)));
}

move = function()
{
	wallcheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
	wallcheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
	if (wallcheckX != noone)
	{
		vectVelocity[0] = 0; //replace with proper scoot process!
	}
	if (wallcheckY != noone)
	{
		vectVelocity[1] = 0; //replace with proper scoot process!
	}
	x += vectVelocity[0];
	y += vectVelocity[1];
}