for (var i = 0; i < 4; i ++)
{
	instance_create_layer(x, y, "PlayerThings", oSmallRocket, {spread : spread, angle : angle, vectVelocity : vectVelocity, tag : tag, damage: damage});
}

instance_destroy(id);
//creates 4 rockets with spread