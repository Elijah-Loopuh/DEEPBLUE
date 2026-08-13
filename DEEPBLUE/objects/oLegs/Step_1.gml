vectPos = [x, y]; //tracks position

updateVars();

handleSprint();

updateVectorMoveInput();

updateVelocityVector();

applyDrag();

handleDash();

setAngle();

handleCollisionNew();

handleAnimation();

move();



/*
show_debug_message(oGlobalData.vectLength(oGlobalData.vectGetComponent([10, 0], oGlobalData.vectSum(oGlobalData.vectInvert(vectPos), oLockBox.vectPos))));

/*
show_debug_message("XXX");
show_debug_message(x);
show_debug_message(y);
/*
show_debug_message(grip);