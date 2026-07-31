

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
				hpMax : 100, 
				gimmick : "none", 
			}, 
			{ //fast leg
				name : "fast leg", 
				regularGrip : 8.0, //regular grip
				sprintGrip : 3.0,  //lower grip for sprinting
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
				hpMax : 50, 
				gimmick : "none", 
			}, 
			{ //stealth leg
				name : "stealth leg", 
				regularGrip : 0.75, //regular grip
				sprintGrip : 0.5,  //lower grip for sprinting
				regularSpeedCap : 15,
				sprintSpeedCap : 30,
				dragStatic : 0.07, //drag when no buttons held
				dragDynamic : 0.0,//drag when movement buttons are held
				dashPower : 35, //dash speed
				dashCooldownMaster : 60*1, //# of frames between dash initiations
				dashDurationMaster : 60*0.20,
				sprite : sStealthLegs
			}, 
			{ //stealth body
				name : "stealth body", 
				main : [0, -1, -1, -1, -1], //0 = available slot, -1 = unavailable, string text = assigned to that equipment
				aux : [0, -1, -1, -1, -1], 
				def : [0, -1, -1, -1, -1], 
				sprite : sStealthBody, 
				mainOffsets: [[0, -14]], //stores coordinates of weapon mounts relative to sprite origin as vectors, idicies match with slot indicies
				auxOffsets: [[0, 14]], 
				defOffsets: [[-14, 0]],
				hpMax : 75, 
				gimmick : "stealth", 
			},
			{ //middle mg
				name : "middle mg", //used for easier handling
				slotType : "aux", //used to figure out slot type 
				fireDelayMaster : 0.08 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oMiddleBullet, //single bullet projectile
				projectileOffest : [32, -1], //pixel offset from sprite origin
				spread : 2, //spread in degrees
				sprite : sMiddleMachineGun, 
				mountOffset : [0, 0] //filled in when gun is assigned to a slot. placeholder
			}, 
			{ //shotgun
				name : "shotgun", //used for easier handling
				slotType : "main", //used to figure out slot type 
				fireDelayMaster : 0.5 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oShotGunShell, //invisible handler spawns multiple bullets
				projectileOffest : [38, 0], //pixel offset from sprite origin to spawn bullets at
				spread : 5, //spread in degrees
				sprite : sShotGun, 
				mountOffset : [0, 0] //filled in when gun is assigned to a slot. placeholder
			}, 
		];

		
		equippedLegs = "default leg"; //stores the name of frame peices equipped
		equippedBody = "default body";
		
		equippedGuns = [["middle mg", mb_left], ["middle mg", mb_left], ["shotgun", mb_right]];
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
		
		getSlotIndex = function(slotName) //returns the index of the lowest unoccupied slot (-1 if all slots full)
		{
			if (slotName == "main") //looks for right type of slot
			{
				for (var i = 0; i < array_length(partData[getPartIndex(equippedBody)].main); i ++) //loos at slots in order from lowest
				{
					if (partData[getPartIndex(equippedBody)].main[i] == 0) //makes sure slot is valid
					{
						return i;
					}
					if (partData[getPartIndex(equippedBody)].main[i] == -1) //return -1 if all slots are full
					{
						return -1;
					}
				}
			}
			if (slotName == "aux")
			{
				for (var i = 0; i < array_length(partData[getPartIndex(equippedBody)].aux); i += 1)
				{
					if (partData[getPartIndex(equippedBody)].aux[i] == 0)
					{
						return i;
					}
					if (partData[getPartIndex(equippedBody)].main[i] == -1)
					{
						return -1;
					}
				}
			}
			if (slotName == "def")
			{
				for (var i = 0; i < array_length(partData[getPartIndex(equippedBody)].def); i ++)
				{
					if (partData[getPartIndex(equippedBody)].def[i] == 0)
					{
						return i;
					}
					if (partData[getPartIndex(equippedBody)].main[i] == -1)
					{
						return -1;
					}
				}
			}
			show_error("oGlobalData.setSlotIndex couldn't find slot type: " + slotName, true); //abort if invalid name
		}
		
		fillSlot = function(slotName, index, wepName) //fills slot with weapon name, marking it as full
		{			
			if (slotName == "main") //looks for right type of slot
			{
				if (partData[getPartIndex(equippedBody)].main[index] == 0) //makes sure slot is valid
				{
					partData[getPartIndex(equippedBody)].main[index] = wepName;
					return;
				}
			}
			if (slotName == "aux")
			{
				if (partData[getPartIndex(equippedBody)].aux[index] == 0)
				{
					partData[getPartIndex(equippedBody)].aux[index] = wepName;
					return;
				}
			}
			if (slotName == "def")
			{
				if (partData[getPartIndex(equippedBody)].def[index] == 0)
				{
					partData[getPartIndex(equippedBody)].aux[index] = wepName;
					return;
				}
			}
			show_error("oGlobalData.fillSlot couldn't find slot type: " + slotName, true); //abort if invalid slot
		}
		
		getMountOffset = function(slotName, index)
		{
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
		
		initalizePlayerGun = function(name, key)
		{
			partIndex = getPartIndex(name); //stores the index of the globalData array entry for this part
			
			dataStruct = partData[partIndex]; //duplicate data structure from the globalData array
			
			slotType = dataStruct.slotType; //stores the slot type of this equipment (main, aux, def)
			
			slotIndex = getSlotIndex(slotType); //gets the equipment slot index in the oBody data that will hold this weapon
			
			if (slotIndex != -1) //only initialize the gun if there is a valid slot to put it in
			{
			
				dataStruct.mountOffset = getMountOffset(slotType, slotIndex); //setup mount offset & equip weapon in slot
			
				show_debug_message(slotType);
				show_debug_message(slotIndex);
				show_debug_message(name);
			
				fillSlot(slotType, slotIndex, name); //fills the designated slot with this weapon's name
			
				dataStruct.fireKey = key; //setup weapon group
			
				instance_create_layer(600, 600, "PlayerThings", oGun, partData[partIndex]); //creates a gun object with proper data
			}
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
		
		getWepInputs = function(input) //returns true if the supplied key is held down, used to manage weapon groups
		{
			if (input = mb_left)
			{
				return mouse_check_button( mb_left );
			}
			else if (input = mb_right)
			{
				return mouse_check_button( mb_right );
			}
			else if (input = ord( "Q" ))
			{
				return keyboard_check(ord("Q"));
			}
			else if (input = ord( "E" ))
			{
				return keyboard_check(ord("E"));
			}
			show_error("oGlobalData.getWepInputs couldn't find input: " + input, true); //abort if invalid program
		}
		
		symmetricalSQRT = function(input) //mirrors sqrt over x & y axes to give negative results for negative inputs. (kinda looks like a sigmoid, IS NOT A SIGMOID)
		{
			if (input >= 0) //normal sqrt
			{
				return sqrt(input);
			}
			
			if (input < 0) //inverse sqrt
			{
				return -sqrt(-input);
			}
		}
}