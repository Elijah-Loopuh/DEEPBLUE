image_angle = random_range(0, 360);

vectVelocity = [0, random_range(3, 9)];

vectVelocity = oGlobalData.vectRotate(vectVelocity, image_angle);

alarm[0] = 60*1;