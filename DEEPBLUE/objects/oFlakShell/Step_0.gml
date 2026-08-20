x += vectVelocity[0];
y += vectVelocity[1];

checkCollision();



instance_create_layer(x, y, "PlayerThings", oSmokeParticle);