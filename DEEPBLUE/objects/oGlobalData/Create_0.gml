

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
			if (vectLength(vect1) != 0)
			{
				if (vectLength(vect1) > scalar)
				{
					return vectClamp(vect1, scalar);
				}
				else
				{
					return vect1;
				}
			}
		}