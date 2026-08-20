
//hard set movement params
id.depth = 800;
angleStore = 0;
snapSpeed = 0.5; //threshold to snap to a speed value
vectVelocity = [0, 0]; //tracks 2d Velocity
vectMoveInput = [0, 0]; //tracks 2d inputs
vectPos = [x, y]; //tracks position
regularGrip = 1.25; //regular grip
regularSpeedCap = 15;
dragStatic = 0.15; //drag when no buttons held
dragDynamic = 0.0; //drag when movement buttons are held
hp = 100;

//ai control variables
standoff = 600; //distance the cycler will hold from player
tolerance = 100; //distance from standoff where the enemy won't correct it's distance
twitch = 45; //angle offset the enemy will use when getting back to standoff
rotationDirection = 1; //can be set to +1 or -1 to control direction of rotation
countdownMax = 15; //max seconds between direction switches
reverseCountdown = irandom(60 * countdownMax);

//variable assigning
grip = regularGrip; //rate of change of vectVelocity axis under normal conditions
speedCap = regularSpeedCap; //tracks current speed cap
drag = dragStatic; //fraction d/1 of speed lost every 
animationSpeed = 1/45; //multiplier from vectVelocity scale to animation fps

takeDamage = function(ammount) //take damage and die if out of hp
{
	hp -= ammount; //take damage number out of health value
	if (hp <= 0)
	{
		instance_destroy();
	}
}

updateVars = function() //updates variables
{
	speedCap = regularSpeedCap;
	underSpeed = oGlobalData.vectLength(vectVelocity) <= speedCap; //tracks if player has control of the mech
	keyMove = (oGlobalData.vectLength(vectMoveInput) > 0);
	vectPos = [x, y];
}

updateVectorMoveInput = function() //ai movement coding
{
	vectMoveInput = oGlobalData.vectSum(oGlobalData.vectInvert(vectPos), oBody.vectPosTarget); //create vector pointing from enemy to target
	
	vectMoveInput = oGlobalData.vectRotate(vectMoveInput, 75 * rotationDirection); //rotate vector to circle player
	
	if (oGlobalData.vectLength(vectMoveInput) > standoff + tolerance)
	{
		vectMoveInput = oGlobalData.vectRotate(vectMoveInput, (0 - twitch * rotationDirection)); //roate vector to close in on player
	}
	if (oGlobalData.vectLength(vectMoveInput) < standoff - tolerance)
	{
		vectMoveInput = oGlobalData.vectRotate(vectMoveInput, (0 + twitch * rotationDirection)); //roate vector to back off from player
	}
	
	vectMoveInput = oGlobalData.vectClamp(vectMoveInput);
	
	reverseCountdown -= 1; //count down until switching direction
	if (reverseCountdown <= 0)
	{
		reverseCountdown = irandom(60 * countdownMax); //reset countdown
		rotationDirection *= -1; //reverse direction
	}
}

updateVectVelocity = function() //handles move input & drag application
{
	underSpeed = oGlobalData.vectLength(vectVelocity) <= speedCap; //tracks if player has control of the mech
	if (keyMove && underSpeed) //low grip when move inputs allowed
	{
		drag = dragDynamic;
		vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectScale(vectMoveInput, grip)); //modifies velocity with move input
		vectVelocity = oGlobalData.vectMax(vectVelocity, speedCap); //cap speed under normal circumstances
	}
	else //high drag when no input allowed
	{
		drag = dragStatic;
	}
	
	vectVelocity = oGlobalData.vectSum(vectVelocity, oGlobalData.vectInvert(oGlobalData.vectScale(vectVelocity, drag))); //apply drag
	if (oGlobalData.vectLength(vectVelocity) < snapSpeed) //anti fluttering
	{
		//vectVelocity = oGlobalData.vectZero;
	}
	
	if (abs(oGlobalData.vectLength(vectVelocity) - speedCap) < snapSpeed && false) //anti fluttering
	{
		//vectVelocity = oGlobalData.vectMax(vectVelocity, speedCap); //snap to speed cap to prevent fluttering
	}
}

setAngle = function(angleTarget = -oGlobalData.vectAngle(vectVelocity))
{
	angleStore = image_angle;
	if (oGlobalData.vectAngle(vectVelocity) != -1) //valid angle target
	{
		image_angle = angleTarget;
	}
	if (checkCollision() != 0) //if turn would put inside wall, reset
	{
		image_angle = angleStore;
	}
}

checkCollision = function() //checks for collisions without actually handling them. 0 = none, 1 = x axis, 2 = y axis, 3 = both axes.
{
	wallCheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
	wallCheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
	output = 0;
	if (wallCheckX != noone)
	{
		output += 1;
	}
	if (wallCheckY != noone)
	{
		output += 2;
	}
	return output;
}

handleCollisionNew = function() //snaps to walls and stops moving, also overrides player rotation
{	
	if (checkCollision() == 1 && checkCollision() != 3 ) //x axis collsion
	{
		if (vectVelocity[1] > 0) //turn to slide on wall
		{
			setAngle(270);
		}
		if (vectVelocity[1] < 0) 
		{
			setAngle(90);
		}
		
		if (checkCollision() == 1) //do collisions
		{
			wallCheckX = instance_place(x + vectVelocity[0], y, oGlobalData.collisionList);
			if (wallCheckX.x > x) //set scoot distance
			{
				snapX = wallCheckX.bbox_left - bbox_right;
			}
			if (wallCheckX.x < x)
			{
				snapX = wallCheckX.bbox_right - bbox_left;
			}
		
			x += snapX; //scoot to wall
			vectVelocity[0] = 0; //stop moving
		}
	}
	
	if (checkCollision() == 2 && checkCollision() != 3 ) //y axis collsion
	{
		if (vectVelocity[0] > 0) //turn to slide wall
		{
			setAngle(0);
		}
		if (vectVelocity[0] < 0)
		{
			setAngle(180);
		}
		
		if (checkCollision() == 2) //do collisions
		{
			wallCheckY = instance_place(x, y + vectVelocity[1], oGlobalData.collisionList);
			if (wallCheckY.y > y) //set scoot distance
			{
				snapY = wallCheckY.bbox_top - bbox_bottom;
			}
			if (wallCheckY.y < y)
			{
				snapY = wallCheckY.bbox_bottom - bbox_top;
			}
		
			y += snapY; //scoot to wall
			vectVelocity[1] = 0; //stop moving
		}
	}
	
	if (checkCollision() == 3)
	{
		vectVelocity[0] = 0;
		vectVelocity[1] = 0;
	}
	
	wallCheck = instance_place(x, y, oGlobalData.collisionList);
	
	if (wallCheck != noone) //if inside wall, push outside of the wal
	{
		if (wallCheck.x + 32 > x)
		{
			x += wallCheck.bbox_left - bbox_right;
			vectVelocity[0] = -5;
			//show_debug_message("pushout to left");
		}
		if (wallCheck.x + 32 < x)
		{
			x += wallCheck.bbox_right - bbox_left;
			vectVelocity[0] = 5;
			//show_debug_message("pushout to right");
		}
		if (wallCheck.y + 32 > y)
		{
			y += wallCheck.bbox_top - bbox_bottom;
			vectVelocity[1] = -5;
			//show_debug_message("pushout to top");
		}
		if (wallCheck.y + 32 < y)
		{
			y += wallCheck.bbox_bottom - bbox_top;
			vectVelocity[1] = 5;
			//show_debug_message("pushout to bottom");
		}
	}
}

move = function()
{
	x += vectVelocity[0];
	y += vectVelocity[1];
}