id.depth = 700;
sprite_index = sprite;
vectPos = [0, 0];
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
		}