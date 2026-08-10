id.depth = 450;
sprite_index = sprite;
image_speed = 0;
fireDelayTracker = fireDelayMaster; //tracks frames between shots
vectPos = [0, 0];
 

	//functions
		
		faceToMouse = function() //points to mouse
		{
			vectPos = [x, y];
			distance = oGlobalData.vectLength(oGlobalData.vectSum(vectPos, oGlobalData.vectInvert(oBasicEnemy.vectPos))); //distance from gun to target
			lead = oGlobalData.vectScale(oBasicEnemy.vectVelocity, distance/oGlobalData.vectLength(vectVelocity)); //displacement from target to aim point
			vectTarget = oGlobalData.vectSum(oBasicEnemy.vectPos, lead); //add calculated lead to enemy position to get aim point
			image_angle = - oGlobalData.vectAngle(oGlobalData.vectSum(oGlobalData.vectInvert(vectPos),vectTarget));
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
			if (fireDelayTracker >= 0) //do trackers
			{
				fireDelayTracker -= 1;
			}
			if (oGlobalData.getWepInputs(fireKey) && fireDelayTracker <= 0) //shoot bullets
			{
				instance_create_layer(vectProjectileOffset[0], vectProjectileOffset[1], "PlayerThings", projectile, {spread : spread, angle : image_angle, vectVelocity: vectVelocity});
				fireDelayTracker = fireDelayMaster;
				image_index = 1;
			}
			if (fireDelayTracker <= fireDelayMaster / 2) //handle animation
			{
				image_index = 0;
			}
		}