id.depth = 600;
sprite_index = sprite;
fireDelayTracker = fireDelayMaster; //tracks frames between shots
vectPos = [0, 0];
vectProjectileOffset = [0, 0];

	//functions
		
		faceToMouse = function() //points to mouse
		{
			vectPos = [x, y];
			vectMouse = [mouse_x, mouse_y];
			image_angle = - oGlobalData.vectAngle(oGlobalData.vectSum(oGlobalData.vectInvert(vectPos),vectMouse));
		}
		
		setPosition = function()
		{
			vectPos = mountOffset; //add offset
			vectPos = oGlobalData.vectRotate(vectPos, -oBody.image_angle); //rotate to align with facing angle
			vectPos = oGlobalData.vectSum(vectPos, oBody.vectPos); //translate to actual position
			x = vectPos[0];
			y = vectPos[1];
			
			vectProjectileOffset = projectileOffest; //add offset
			vectProjectileOffset = oGlobalData.vectRotate(vectProjectileOffset, -image_angle); //turn to align with facing angle
			vectProjectileOffset = oGlobalData.vectSum(vectProjectileOffset, vectPos); //translate to actual position
		}
		
		shootBullet = function()
		{
			if (fireDelayTracker <= 0)
			{
				if (mouse_check_button(mb_left))
				{
					instance_create_layer(vectProjectileOffset[0], vectProjectileOffset[1], "PlayerThings", projectile, {spread : spread, angle : image_angle});
					fireDelayTracker = fireDelayMaster;
				}
			}
			else
			{
				fireDelayTracker -= 1;
			}
		}