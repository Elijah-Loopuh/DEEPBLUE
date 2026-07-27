

//data structures

		collisionList = //contains a list of collidable objects
		[
			oWall
		]


//functions

		vectSum = function (vect1, vect2) //sums two vectors
		{
			vectOutput = [0, 0];
			vectOutput[0] = vect1[0] + vect2[0];
			vectOutput[1] = vect1[1] + vect2[1];
			return vectOutput;
		}

		vectScale = function(vect1, scalar) //returns the vector inputted with both axes multiplied by the scalar
		{
			vectOutput = [0, 0];
			vectOutput[0] = vect1[0] * scalar;
			vectOutput[1] = vect1[1] * scalar;
			return vectOutput;
		}

		vectInvert = function (vect1) //inverts supplied vector
		{
			return vectScale(vect1, -1);
		}

		vectLength = function (vect1) //returns the length of supplied vector
		{
			return sqrt(sqr(vect1[0]) + sqr(vect1[1]));
		}

		vectClamp = function (vect1, scalar) //returns the vector with it's length snapped to the scalar (makes it a unit vector) unless length og 0, then returns input vector
		{
			if (vectLength(vect1) != 0)
			{
				return vectScale(vect1, scalar / vectLength(vect1))
			}
			else
			{
				return vect1;
			}
		}
		
		vectMax = function(vect1, scalar) //caps vect1 to the scalar, but doesn't snap if within bounds. also returns 0,0 if vect is 0,0
		{
			if (vectLength(vect1) > scalar) //return clamped
			{
				return vectClamp(vect1, scalar);
			}
			else //return untouched
			{
				return vect1;
			}
		}
		
		vectAngle = function(vect1) //returns degrees above 0 (facring right) of the vect1
		{
			angle = darctan(vect1[1]/vect1[0]);
			
			if (vect1[0] > 0 && vect1[1] > 0) //bottom right quad
			{
				return angle;
			}
			if (vect1[0] < 0) //left half
			{
				return 180 + angle;
			}
			if (vect1[0] > 1 && vect1[1] < 1) //top right quad
			{
				return 360 + angle;
			}
			
			show_debug_message("oGlobalData.vectAngle possible error")
			return -1;
		}