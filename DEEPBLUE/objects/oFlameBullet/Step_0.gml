x += vectVelocity[0];
y += vectVelocity[1];

vectVelocity = oGlobalData.vectRotate(vectVelocity, random_range(-spread, spread));

image_angle = -oGlobalData.vectAngle(vectVelocity);

checkCollision();

if (alarm[0] % 10 == 0)
{
	instance_create_layer(x, y, "PlayerThings", oSmokeParticle);
}