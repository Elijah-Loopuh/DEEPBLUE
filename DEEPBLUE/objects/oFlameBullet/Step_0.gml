x += vectVelocity[0];
y += vectVelocity[1];

vectVelocity = oGlobalData.vectRotate(vectVelocity, random_range(-spread, spread));

image_angle = -oGlobalData.vectAngle(vectVelocity);

checkCollision();