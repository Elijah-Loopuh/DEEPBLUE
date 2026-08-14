id.depth = 475;

setupBullet = function()
{
	image_angle = angle; //face aimed angle
	image_angle += random_range(-spread, spread); //spread
	vectVelocity = oGlobalData.vectRotate(vectVelocity, -image_angle); //setup vector for direction
	//vectVelocity = oGlobalData.vectSum(vectVelocity, oLegs.vectVelocity); //add player velocity to bullet velocity
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

setupBullet();

alarm[0] = 60*3;

instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
instance_create_layer(x, y, "PlayerThings", oSmokeParticle);