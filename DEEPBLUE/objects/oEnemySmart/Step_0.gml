for (var i = 0; i < 10; i ++) //visual particle effect
{
	instance_create_layer(x, y, "Instances", oSmokeParticle);
}

if (dodgeCooldownTracker >= 0) //normal movement
{
	vectVelocity[0] = moveSpeed;
	vectVelocity[1] = 0;
	
	vectOffset = oGlobalData.vectSum(oGlobalData.vectInvert(vectPos), oBody.vectPosTarget);
	
	vectVelocity = oGlobalData.vectRotateTo(vectVelocity, vectOffset);
	
	dodgeCooldownTracker -= 1;
	dodgeDurationTracker = dodgeDuration + 1; //over duration = not dodging
}
else //dodge handling
{
	if (dodgeDurationTracker > dodgeDuration) //start dodge
	{
		dodgeDurationTracker = dodgeDuration;
		
		vectVelocity = oGlobalData.vectScale(vectVelocity, 3);
		vectVelocity = oGlobalData.vectRotate(vectVelocity, 90);
		
		instance_create_layer(x, y, "PlayerThings", oSmallRocket, rocketData); //shoot rocket at the player
	}
	if (dodgeDurationTracker > 0) //execute dodge
	{
		dodgeDurationTracker -=1;
	}
	if (dodgeDurationTracker == 0) //end dodge
	{
		dodgeCooldownTracker = dodgeCooldown;
	}
}

x += vectVelocity[0];
y += vectVelocity[1];

vectPos = [x, y];