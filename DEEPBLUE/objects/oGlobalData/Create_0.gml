

//data structures

		collisionList = //contains a list of collidable objects
		[
			oWall, 
		];


		partData = //data for all parts
		[
			{ //default leg
				name : "default leg", 
				regularGrip : 1.25, //regular grip
				sprintGrip : 1.0,  //lower grip for sprinting
				regularSpeedCap : 15,
				sprintSpeedCap : 35,
				dragStatic : 0.15, //drag when no buttons held
				dragDynamic : 0.0,//drag when movement buttons are held
				dashPower : 50, //dash speed
				dashCooldownMaster : 60*0.75, //# of frames between dashes
				dashDurationMaster : 60*0.25,
				sprite : sDefaultLegs
			}, 
			{ //default body
				name : "default body", 
				main : [0, -1, -1, -1, -1], //0 = available slot, -1 = unavailable, string text = assigned to that equipment
				aux : [0, 0, -1, -1, -1], 
				def : [0, -1, -1, -1, -1], 
				sprite : sDefaultBody
			}, 
			{ //fast leg
				name : "fast leg", 
				regularGrip : 4.0, //regular grip
				sprintGrip : 2.0,  //lower grip for sprinting
				regularSpeedCap : 30,
				sprintSpeedCap : 50,
				dragStatic : 0.30, //drag when no buttons held
				dragDynamic : 0.0,//drag when movement buttons are held
				dashPower : 75, //dash speed
				dashCooldownMaster : 60*0.25, //# of frames between dash initiations
				dashDurationMaster : 60*0.25,
				sprite : sFastLegs
			}, 
			{ //fast body
				name : "fast body", 
				main : [-1, -1, -1, -1, -1], //0 = available slot, -1 = unavailable, string text = assigned to that equipment
				aux : [0, -1, -1, -1, -1], 
				def : [0, -1, -1, -1, -1], 
				sprite : sFastBody
			}, 
		];

		
		equippedLegs = "default leg"; //stores the name of frame peices equipped
		equippedBody = "default body";
		
//functions

	//vector  functions
	
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
		
		vectAngle = function(vect1) //returns degrees clockwise of straight right, the direction of vect1
		{
			angle = darctan(vect1[1]/vect1[0]);
			
			//quadrant checks
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
			
			//axis checks
			if (vect1[0] == 0) //axis checks
			{
				if (vect1[1] < 0) //straight down
				{
					return 270;
				}
				if (vect1[1] > 0) //straight up
				{
					return 90;
				}
			}
			if (vect1[1] == 0) //axis checks
			{
				if (vect1[0] < 0)
				{
					return 180;
				}
				if (vect1[0] > 0)
				{
					return 0;
				}
			}
			
			return -1;
		}
		
		vectRotate = function(vect1, scalar) //returns vector rotated clockwise by scalar degrees
		{
			vectOutput = [0, 0];
			vectOutput[0] = x*dcos(scalar) - y*dsin(scalar);
			vectOutput[1] = x*dsin(scalar) + y*dcos(scalar);
		}
		
		
	//partData functions
	
		getPartIndex = function(name) //returns partData index matching the name requested. returns -1 as an error code
		{
			for (i = 0; i < array_length(partData); i ++)
			{
				if (partData[i].name == name)
				{
					return i;
				}
			}
			show_error("didn't find part name: " + name, true); //abort if invalid name
		}
		
		initalizePlayerLegs = function(name)
		{
			index = getPartIndex(name); //get data location
			
			//assign variables
			oLegs.regularGrip = partData[index].regularGrip;
			oLegs.sprintGrip = partData[index].sprintGrip;
			oLegs.regularSpeedCap = partData[index].regularSpeedCap;
			oLegs.sprintSpeedCap = partData[index].sprintSpeedCap;
			oLegs.dragStatic = partData[index].dragStatic;
			oLegs.dragDynamic = partData[index].dragDynamic;
			oLegs.dashPower = partData[index].dashPower;
			oLegs.dashCooldownMaster = partData[index].dashCooldownMaster;
			oLegs.dashDurationMaster = partData[index].dashDurationMaster;
			oLegs.sprite_index = partData[index].sprite;
		}
		
		initalizePlayerBody = function(name)
		{
			index = getPartIndex(name); //get data location
			
			//assign variables
			oBody.main = partData[index].main; //stores the number of available slots of each type
			oBody.aux = partData[index].aux; 
			oBody.def = partData[index].def; 
			oBody.sprite_index = partData[index].sprite;
		}
		
		
	//other functions
		
		function spawn_walls(x, y, width /*use room width*/, height /*use room height*/) // replaces devMarker with proper walls
		{
		    var w = width/64 + 2;
		    var h = height/64 + 2;

		    for (var yy = 0; yy < h; yy++)
		    {
		        for (var xx = 0; xx < w; xx++)
		        {
					//show_debug_message(xx*32)
					//show_debug_message(yy*32)
		            //check for devmarker
		            if (position_meeting((xx*64)+32, (yy*64)+32, oWallMarker))
		            {
		                instance_create_layer(
		                    x + xx * 64,
		                    y + yy * 64,
		                    "Instances",
		                    oWall
		                );
						//show_debug_message("wall spawned");
		            }
		        }
		    }
		}
		
		function spawn_room_walls(x, y, width /*use room width*/, height /*use room height*/) // makes room wall boundaries
		{
		    var w = width/64 + 2;
		    var h = height/64 + 2;

		    for (var yy = 0; yy < h; yy++)
		    {
		        for (var xx = 0; xx < w; xx++)
		        {
		            // 2-tile thick border condition
		            if (xx < 2 || xx >= w - 2 || yy < 2 || yy >= h - 2)
		            {
		                instance_create_layer(
		                    x + xx * 64,
		                    y + yy * 64,
		                    "Instances",
		                    oWall
		                );
		            }
		        }
		    }
		}