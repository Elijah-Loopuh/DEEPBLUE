id.depth = 475;

setupBullet = function()
{
	
	vectDirection = oGlobalData.vectClamp(oGlobalData.vectSum(oGlobalData.vectInvert([x, y]), oLockBox.vectPos)); //gets a vector that points to the target
	
	image_angle = -oGlobalData.vectAngle(vectDirection);
	image_angle += random_range(-spread, spread); //spread
	
	vectVelocity = oGlobalData.vectRotate(vectVelocity, -image_angle); //rotate to face aimed direction
	accel = oGlobalData.vectLength(vectVelocity); //acceleration per turn
	agility = 5; //degrees per frame the rocket turns
}

checkCollision = function()
{
	for (var i = 0; i < 5; i ++)
	{
		if (instance_place(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.collisionList))
		{
			instance_destroy(id);
		}
	}
}

doTracking = function()
{
	vectDirection = oGlobalData.vectClamp(oGlobalData.vectSum(oGlobalData.vectInvert([x, y]), oLockBox.vectPos)); //gets a vector that points to the target
	
	angleOff = oGlobalData.vectAngle(vectDirection) - oGlobalData.vectAngle(vectVelocity); //calculate mis aim vector
	
	vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectClamp(vectVelocity, accel));
	
	if (angleOff < 0) //normalize angle 
	{
		angleOff += 360;
	}
	
	if (angleOff > 180) //steer towards target
	{
		vectVelocity = oGlobalData.vectRotate(vectVelocity, -agility);
	}
	if (angleOff < 180)
	{
		vectVelocity = oGlobalData.vectRotate(vectVelocity, agility);
	}
	
	image_angle = -oGlobalData.vectAngle(vectVelocity); //rotate image to align with velocity
}

setupBullet();

alarm[0] = 60*10;