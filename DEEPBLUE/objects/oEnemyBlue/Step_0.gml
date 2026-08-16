vectPos = [x, y];

vectVelocity = oGlobalData.vectSum( oGlobalData.vectInvert(vectPos), oBody.vectPosTarget);

vectVelocity = oGlobalData.vectClamp(vectVelocity, moveSpeed);

vectVelocity = oGlobalData.vectRotate(vectVelocity, -65);

x += vectVelocity[0]
y += vectVelocity[1]
/*
show_debug_message("xxxx");
show_debug_message(vectPos);
show_debug_message(vectVelocity);
