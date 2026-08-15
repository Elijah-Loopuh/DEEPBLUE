vectPos = [x, y]; //tracks position

updateVars();

handleSprint();

updateVectorMoveInput();

updateVectVelocity();

handleDash();

setAngle();

handleCollisionNew();

handleAnimation();

move();



show_debug_message(string(oGlobalData.vectLength(vectVelocity)));
/*

/*
show_debug_message("XXX");
show_debug_message(x);
show_debug_message(y);
/*
show_debug_message(grip);