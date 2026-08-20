

updateVars();

updateVectorMoveInput();

if (keyboard_check( ord("T") ))
{
	grip = 0;
}
else
{
	grip = regularGrip;
}

updateVectVelocity();

setAngle();

handleCollisionNew();

move();

