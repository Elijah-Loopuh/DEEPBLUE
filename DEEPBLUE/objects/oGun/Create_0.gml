id.depth = 450;
sprite_index = sprite;
image_speed = 0;
fireDelayTracker = 60*0.1; //tracks frames between shots
vectPos = [0, 0];
 

	//functions
		
		faceToMouse = function() //points to mouse & does lead calculation
		{
			vectPos = [x, y];
			
			distance = oGlobalData.vectLength(oGlobalData.vectSum(vectPos, oGlobalData.vectInvert(oLockBox.vectPos))); //distance from gun to target
			
			lead = oGlobalData.vectScale(oLockBox.vectVelocity, distance/oGlobalData.vectLength(vectVelocity)); //displacement from target to aim point
			
			vectTarget = oGlobalData.vectSum(oLockBox.vectPos, lead); //add calculated lead to enemy position to get aim point
			
			//repeats lead calculation b/c distance to target point is not the same as the distance to actual target
			distance = oGlobalData.vectLength(oGlobalData.vectSum(vectPos, oGlobalData.vectInvert(vectTarget))); //distance from gun to target
			
			lead = oGlobalData.vectScale(oLockBox.vectVelocity, distance/oGlobalData.vectLength(vectVelocity)); //displacement from target to aim point
			
			vectTarget = oGlobalData.vectSum(oLockBox.vectPos, lead); //add calculated lead to enemy position to get aim point
			
			
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
				instance_create_layer(vectProjectileOffset[0], vectProjectileOffset[1], "PlayerThings", projectile, {spread : spread, angle : image_angle, vectVelocity: vectVelocity, tag : tag, damage : damage});
				fireDelayTracker = fireDelayMaster;
				image_index = 1;
				oBody.vectPosTarget = oBody.vectPos;
				oBody.vectVelocityTarget = oBody.vectVelocity;
			}
			if (fireDelayTracker <= fireDelayMaster / 2) //handle animation
			{
				image_index = 0;
			}
		}