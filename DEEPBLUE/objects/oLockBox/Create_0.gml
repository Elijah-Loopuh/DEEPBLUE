//NOTE these are not always the actual position and velocity of the object
vectPos = [0, 0]; //stores the location for guns to aim at
vectVelocity = [0, 0]; //stores the motion for leading shots

goToMouse = function() //snap to mouse every frame
{
	x = mouse_x;
	y = mouse_y;
}

getTarget = function() //set target location & speed for auto aim
{
	if (place_meeting(x, y, oGlobalData.enemyList)) //if targetable enemy shoot them
	{
		target = instance_nearest(x, y, oEnemyParent);
		vectPos = target.vectPos;
		vectVelocity = target.vectVelocity;
	}
	else //if no target, shoot at cursor with no lead
	{
		vectPos = [x, y];
		vectVelocity = [0, 0];
	}
}