setupBullet = function()
{
	image_angle = angle; //face aimed angle
	id.depth = 475;
	image_angle += random_range(-spread, spread); //spread
	vectVelocity = oGlobalData.vectRotate(vectVelocity, -image_angle); //setup vector for direction
	//vectVelocity = oGlobalData.vectSum(vectVelocity, oLegs.vectVelocity); //add player velocity to bullet velocity
}

checkCollision = function()
{
	for (var i = 0; i < 5; i ++)
	{
		if (place_meeting(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.collisionList)) //if going to hit a wall
		{
			instance_destroy(); //destroy if you hit a wall
		}
		if (place_meeting(x + vectVelocity[0]*i*0.25, y + vectVelocity[1]*i*0.25, oGlobalData.enemyList)) //if hitting enemy
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