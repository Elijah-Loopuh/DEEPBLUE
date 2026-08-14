x += vectVelocity[0];
y += vectVelocity[1];

doTracking();

checkCollision();

for (var i = 0; i < 5; i ++)
{
	instance_create_layer(x, y, "playerThings", oSmokeParticle);
}