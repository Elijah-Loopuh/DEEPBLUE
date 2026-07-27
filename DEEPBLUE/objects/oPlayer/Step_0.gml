
checkKeys();

updateVectorMoveInput();

updateVelocityVector();


if (!keyMove)
{
	applyDrag();
}


move();
show_debug_message("XXXXX");
show_debug_message(vectVelocity[0]);
show_debug_message(vectVelocity[1]);
show_debug_message("XXXXX");