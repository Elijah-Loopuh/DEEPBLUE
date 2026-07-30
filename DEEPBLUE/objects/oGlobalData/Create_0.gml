

//data structures
{
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
				sprite : sDefaultBody, 
				mainOffsets: [[16, 0]], //stores coordinates of weapon mounts relative to sprite origin as vectors, idicies match with slot indicies
				auxOffsets: [[-11, -7], [-11, 7]], 
				defOffsets: [[-20, 0]],
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
				sprite : sFastBody, 
				mainOffsets: [[]], //stores coordinates of weapon mounts relative to sprite origin as vectors, idicies match with slot indicies
				auxOffsets: [[-11, -17]], 
				defOffsets: [[-1, 17]],
			}, 
			{ //middle mg
				name : "middle mg", //used for easier handling
				slotType : "aux", //used to figure out slot type 
				fireDelayMaster : 0.08 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oMiddleBullet, //not added yet, needs to be implemented!
				projectileOffest : [16, 0], //pixel offset from sprite origin
				spread : 2, //spread in degrees
				sprite : sMiddleMachineGun, 
				mountOffset : [0, 0]
			}, 
		];

		
		equippedLegs = "fast leg"; //stores the name of frame peices equipped
		equippedBody = "fast body";
		
		equippedAux = ["middle mg"];
}
//functions

	//vector  functions
{
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

		vectClamp = function (vect1, scalar = 1) //returns vect1 with length scalar, unless vect1 is [0, 0]. if no scalar, returns a unit vector
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
			//vect1 = oGlobalData.vectClamp()
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
			if (vect1[0] > 0 && vect1[1] < 0) //top right quad
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
			vectOutput[0] = (vect1[0]*dcos(scalar)) - (vect1[1]*dsin(scalar));
			vectOutput[1] = (vect1[0]*dsin(scalar)) + (vect1[1]*dcos(scalar));
			return vectOutput;
		}
		
		vectDotProduct = function(vect1, vect2) //returns the dot product of the two vectors
		{
			output = [0, 0];
			output[0] = vect1[0] * vect2[0];
			output[1] = vect1[1] * vect2[1];
			return output;
		}
		
		vectGetComponent = function(vect1, vect2) //returns the component of vect1 in the vect2 direction
		{
			return vectDotProduct(vect1, vectClamp(vect2));
		}
}
		
	//partData functions
{
		getPartIndex = function(name) //returns partData index matching the name requested. returns -1 as an error code
		{
			for (var i = 0; i < array_length(partData); i ++)
			{
				if (partData[i].name == name)
				{
					return i;
				}
			}
			show_error("oGlobalData.getPartIndex couldn't find part name: " + name, true); //abort if invalid name
		}
		
		setSlotIndex = function(slotName, wepName) //returns the index of the lowest unoccupied slot, and marks it occupied by that weapon
		{
			show_debug_message("slot finding started");
			if (slotName == "main") //looks for right type of slot
			{
				for (var i = 0; i < array_length(partData[getPartIndex(equippedBody)].main); i ++) //loos at slots in order from lowest
				{
					if (partData[getPartIndex(equippedBody)].main[i] == 0) //makes sure slot is valid
					{
						partData[getPartIndex(equippedBody)].main[i] = wepName;
						return i;
					}
				}
				i = 0;
			}
			if (slotName == "aux")
			{
				show_debug_message("found aux type");
				for (var i = 0; i < array_length(partData[getPartIndex(equippedBody)].aux); i += 1)
				{
					if (partData[getPartIndex(equippedBody)].aux[i] == 0)
					{
						show_debug_message("found empty slot")
						partData[getPartIndex(equippedBody)].aux[i] = wepName;
						return i;
					}
				}
			}
			if (slotName == "def")
			{
				for (var i = 0; i < array_length(partData[getPartIndex(equippedBody)].def); i ++)
				{
					if (partData[getPartIndex(equippedBody)].def[i] == 0)
					{
						partData[getPartIndex(equippedBody)].aux[i] = wepName;
						return i;
					}
				}
			}
			show_error("oGlobalData.getSlotIndex couldn't find slot type: " + slotName, true); //abort if invalid name
		}
		
		getMountOffset = function(slotName, index)
		{
			show_debug_message("offset declaration started")
			if (slotName == "main") //looks for right type of slot
			{
				return partData[getPartIndex(equippedBody)].mainOffsets[index];
			}
			if (slotName == "aux")
			{
				return partData[getPartIndex(equippedBody)].auxOffsets[index];
			}
			if (slotName == "def")
			{
				return partData[getPartIndex(equippedBody)].defOffsets[index];
			}
			show_error("oGlobalData.getMountOffset couldn't find slot type: " + slotName, true); //abort if invalid name
		}
		
		initalizePlayerLegs = function(name)
		{
			index = getPartIndex(name); //get data location
			instance_create_layer(600, 600, "PlayerThings", oLegs, partData[index]); //creates a legs object with proper data
		}
		
		initalizePlayerBody = function(name)
		{
			index = getPartIndex(name); //get data location
			instance_create_layer(0, 0, "PlayerThings", oBody, partData[index]); //creates a body object with proper data
		}
		
		initalizePlayerGun = function(name)
		{
			show_debug_message("gun init started");
			index = getPartIndex(name);
			show_debug_message("index got");
			dataStruct = partData[index];
			show_debug_message("data struct created");
			dataStruct.mountOffset = getMountOffset(dataStruct.slotType, setSlotIndex(dataStruct.slotType, dataStruct.name));
			show_debug_message("offset declared");
			instance_create_layer(600, 600, "PlayerThings", oGun, partData[index]); //creates a gun object with proper data
			show_debug_message("gun init done");
		}
}
		
	//other functions
{
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
}