id.depth = 500;
sprite_index = sprite;

vectPos = [0, 0]; //tracks real position and velocity, used to do animations and such
vectVelocity = [0, 0];

vectPosTarget = [0, 0]; //used by enemies to target the player
vectVelocityTarget = [0, 0];

hp = hpMax;
//function definitions

	faceToMouse = function() //points to mouse
	{
		vectMouse = [mouse_x, mouse_y];
		image_angle = - oGlobalData.vectAngle(oGlobalData.vectSum(oGlobalData.vectInvert(vectPos),vectMouse));
	}
		
	updatePosition = function()
	{
		x = oLegs.x;
		y = oLegs.y;
		
		if (gimmick == "stealth") //stealth velocity tracking
		{
			if (oGlobalData.frameCounter % 30 == 0) //update twice per second
			{
				vectPosTarget = oLegs.vectPos;
				vectVelocityTarget = oLegs.vectVelocity;
		
				vectPosTarget = oGlobalData.vectScramble(oLegs.vectPos, oLegs.regularSpeedCap * 30);
				vectVelocityTarget = oGlobalData.vectScramble(oLegs.vectVelocity, oLegs.regularGrip * 30);
			}
		}
		else //normal velocity & position tracking
		{
			vectPosTarget = oLegs.vectPos;
			vectVelocityTarget = oLegs.vectVelocity;
		}
		
		vectPos = [x, y]; //used to point at target
	}
		
	takeDamage = function(ammount)
	{
		hp -= ammount;
		if (hp <= 0)
		{
			show_message("You Are Dead :)");
		}
	}