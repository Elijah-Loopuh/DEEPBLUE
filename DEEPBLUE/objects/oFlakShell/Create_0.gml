id.depth = 475;

setupBullet = function()
{
	image_angle = angle; //face aimed angle
	image_angle += random_range(-spread, spread); //spread
	vectVelocity = oGlobalData.vectRotate(vectVelocity, -image_angle); //setup vector for direction
}

checkCollision = function()
{
	if ((instance_place(x, y, oGlobalData.collisionList) || instance_place(x, y, oGlobalData.enemyList)) && tag == "friendly") //wallcheck collision
	{
		for (var j = 0; j < 12; j ++) //spawn a bunch of flak
		{
			instance_create_layer(x, y, "PlayerThings", oMiddleBullet, {spread : 180, angle : 0, vectVelocity : [20, 0], tag : tag, damage : damage})
		}
		instance_destroy(id);
	}
	if ((instance_place(x, y, oGlobalData.collisionList) || instance_place(x, y, oGlobalData.playerList)) && tag == "enemy") //wallcheck collision
	{
		for (var j = 0; j < 12; j ++) //spawn a bunch of flak
		{
			instance_create_layer(x, y, "PlayerThings", oMiddleBullet, {spread : 180, angle : 0, vectVelocity : [20, 0], tag : tag, damage : damage})
		}
		instance_destroy(id);
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