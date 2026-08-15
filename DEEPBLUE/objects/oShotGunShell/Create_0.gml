for (var i = 0; i < 8; i ++)
{
	instance_create_layer(x, y, "PlayerThings", oMiddleBullet, {spread : spread, angle : angle, vectVelocity : oGlobalData.vectScale(vectVelocity, random_range(0.85, 1.15)), tag : tag, damage: damage});
}

for (var i = 0; i < 16; i ++)
{
	instance_create_layer(x, y, "playerThings", oSmokeParticle);
}

instance_destroy(id);
//creates 8 bullets with spread and random velocity variation