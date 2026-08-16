id.depth = 475;

setupBullet = function()
{
	tracking = true;
	vectDirection = oGlobalData.vectClamp(oGlobalData.vectSum(oGlobalData.vectInvert([x, y]), oLockBox.vectPos)); //gets a vector that points to the target
	loseLockThreshold = 0.1; //seconds from impact to stop tracking at
	
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
		if (place_meeting(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.collisionList)) //if going to hit a wall
		{
			instance_destroy(); //destroy if you hit a wall
		}
		if (place_meeting(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.enemyList) && tag == "friendly") //if hitting enemy
		{
			collided = instance_place(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.enemyList);
			collided.takeDamage(damage); //deal damage
			instance_destroy();
		}
		if (place_meeting(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.playerList) && tag == "enemy") //if hitting enemy
		{
			oBody.takeDamage(damage);
			instance_destroy();
		}
	}
}

doTracking = function()
{
	if (tracking)
	{
		if (tag == "friendly")
		{
			vectDirection = oGlobalData.vectSum(oGlobalData.vectInvert([x, y]), oLockBox.vectPos); //gets a vector that points to the target
		}
		if (tag == "enemy")
		{
			vectDirection = oGlobalData.vectSum(oGlobalData.vectInvert([x, y]), oBody.vectPosTarget); //gets a vector that points to the target
		}
		
		if (oGlobalData.vectLength(vectDirection) < oGlobalData.vectLength(vectVelocity) * 60*loseLockThreshold) //lose tracking when too close to target
		{
			tracking = false;
		}
	}
	
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

alarm[0] = 60*3;