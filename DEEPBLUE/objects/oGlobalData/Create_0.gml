
randomise();
//data structures
{
		collisionList = //contains a list of collidable objects
		[
			oWall, 
		];
		
		
		enemyList = //list of targetable objects
		[
			oEnemyParent, 
		];
		
		playerList = //list of player objects
		[
			oLegs, 
			oBody, 
		];
		
		uiList = 
		[
			rHullScreen, 
			rSlotScreen, 
			rGunScreen
		];
		
		roomList = 
		[
			rTestingRoom, 
		];

		currentSlotData = //stores data used to put guns in slots for the player
		{
			slotType : "", 
			slotIndex : 0, 
		};

		partData = //data for all parts
		[
			{ //default leg
				name : "default leg", 
				regularGrip : 1.25, //regular grip
				sprintGrip : 1.0,  //lower grip for sprinting
				regularSpeedCap : 15,
				sprintSpeedCap : 35,
				dragStatic : 1.0, //drag when no buttons held
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
				regularGrip : 5.0, //regular grip
				sprintGrip : 3.0,  //lower grip for sprinting
				regularSpeedCap : 30,
				sprintSpeedCap : 50,
				dragStatic : 2.0, //drag when no buttons held
				dragDynamic : 0.0,//drag when movement buttons are held
				dashPower : 75, //dash speed
				dashCooldownMaster : 60*0.35, //# of frames between dash initiations
				dashDurationMaster : 60*0.25,
				sprite : sFastLegsNew
			}, 
			{ //fast body
				name : "fast body", 
				main : [-1, -1, -1, -1, -1], //0 = available slot, -1 = unavailable, string text = assigned to that equipment
				aux : [0, -1, -1, -1, -1], 
				def : [0, -1, -1, -1, -1], 
				sprite : sFastBodyNew, 
				mainOffsets: [[]], //stores coordinates of weapon mounts relative to sprite origin as vectors, idicies match with slot indicies
				auxOffsets: [[-24, -11]], 
				defOffsets: [[-24, 11]],
				hpMax : 50, 
				gimmick : "none", 
			}, 
			
			{ //stealth leg
				name : "stealth leg", 
				regularGrip : 0.65, //regular grip
				sprintGrip : 0.5,  //lower grip for sprinting
				regularSpeedCap : 10,
				sprintSpeedCap : 25,
				dragStatic : 0.3, //drag when no buttons held
				dragDynamic : 0.0,//drag when movement buttons are held
				dashPower : 35, //dash speed
				dashCooldownMaster : 60*1.25, //# of frames between dash initiations
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
			
			{ //heavy leg
				name : "heavy leg", 
				regularGrip : 0.5, //regular grip
				sprintGrip : 0.35,  //lower grip for sprinting
				regularSpeedCap : 12,
				sprintSpeedCap : 25,
				dragStatic : 0.3, //drag when no buttons held
				dragDynamic : 0.0,//drag when movement buttons are held
				dashPower : 25, //dash speed
				dashCooldownMaster : 60*2.0, //# of frames between dash initiations
				dashDurationMaster : 60*0.75,
				sprite : sHeavyLegs
			}, 
			{ //heavy body
				name : "heavy body", 
				main : [0, 0, -1, -1, -1], //0 = available slot, -1 = unavailable, string text = assigned to that equipment
				aux : [0, 0, 0, -1, -1], 
				def : [0, 0, -1, -1, -1], 
				sprite : sHeavyBody, 
				mainOffsets: [[41, -24], [41, 24]], //stores coordinates of weapon mounts relative to sprite origin as vectors, idicies match with slot indicies
				auxOffsets: [[0, -20], [0, 20], [20, 0]], 
				defOffsets: [[-41, 14], [-41, -14]],
				hpMax : 200, 
				gimmick : "none", 
			},
			
			{ //middle mg
				name : "middle mg", //used for easier handling
				slotType : "aux", //used to figure out slot type 
				fireDelayMaster : 0.2 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oMiddleBullet, //single bullet projectile
				projectileOffest : [32, -1], //pixel offset from sprite origin
				spread : 4, //spread in degrees
				sprite : sMiddleMachineGun, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [50, 0], //projectile velocity
				tag : "friendly", //used by bullets to decide who to hurt
				damage : 8, 
			}, 
			{ //middle rifle
				name : "middle rifle", //used for easier handling
				slotType : "aux", //used to figure out slot type 
				fireDelayMaster : 1.0 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oRifleBullet, //single bullet projectile
				projectileOffest : [33, 0], //pixel offset from sprite origin
				spread : 0, //spread in degrees
				sprite : sMiddleRifle, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [150, 0], 
				tag : "friendly", 
				damage : 25, 
			},
			{ //smallRPG
				name : "smallRPG", //used for easier handling
				slotType : "aux", //used to figure out slot type 
				fireDelayMaster : 2.0 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oSmallRocket, //single bullet projectile
				projectileOffest : [33, 0], //pixel offset from sprite origin
				spread : 10, //spread in degrees
				sprite : sSmallRPG, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [2, 0], //used as acceleration by rockets
				tag : "friendly", 
				damage : 50
			},
			
			{ //shotgun
				name : "shotgun", //used for easier handling
				slotType : "main", //used to figure out slot type 
				fireDelayMaster : 0.75 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oShotGunShell, //invisible handler spawns multiple bullets
				projectileOffest : [38, 0], //pixel offset from sprite origin to spawn bullets at
				spread : 5, //spread in degrees
				sprite : sShotGun, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [35, 0], 
				tag : "friendly", 
				damage : 3, 
			}, 
			{ //flamethrower
				name : "flamethrower", //used for easier handling
				slotType : "main", //used to figure out slot type 
				fireDelayMaster : 0.01 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oFlameBullet, //single bullet projectile
				projectileOffest : [37, 0], //pixel offset from sprite origin
				spread : 5, //spread in degrees
				sprite : sFlameThrower, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [20, 0], //projectile velocity 
				tag : "friendly", 
				damage : 1, 
			}, 
			{ //flak cannon
				name : "flak cannon", //used for easier handling
				slotType : "main", //used to figure out slot type 
				fireDelayMaster : 0.5 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oFlakShell, //single bullet projectile
				projectileOffest : [44, 0], //pixel offset from sprite origin
				spread : 15, //spread in degrees
				sprite : sFlakCannon, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [25, 0],  //projectile velocity 
				tag : "friendly", 
				damage : 5, 
			}, 
			{ //rotary gun
				name : "rotary gun", //used for easier handling
				slotType : "main", //used to figure out slot type 
				fireDelayMaster : 0.05 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oMiddleBullet, //single bullet projectile
				projectileOffest : [49, 0], //pixel offset from sprite origin
				spread : 7, //spread in degrees
				sprite : sRotaryGun, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [40, 0],  //projectile velocity 
				tag : "friendly", 
				damage : 3, 
			}, 
			{ //quad rocket
				name : "quad rocket", //used for easier handling
				slotType : "main", //used to figure out slot type 
				fireDelayMaster : 3.5 * 60, //frames between shots = 1 / (RPM / 60)
				projectile : oRocketBurst, //single bullet projectile
				projectileOffest : [0, 0], //pixel offset from sprite origin
				spread : 180, //spread in degrees
				sprite : sQuadRocket, 
				mountOffset : [0, 0], //filled in when gun is assigned to a slot. placeholder
				vectVelocity : [1, 0],  //projectile velocity 
				tag : "friendly", 
				damage : 25, 
			}, 
		];

		
		equippedLegs = "default leg"; //stores the name of frame peices equipped
		equippedBody = "default body";
		
		vectZero = [0, 0]; //used to set other stuff to
		
		frameCounter = 0;
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
 
		vectClamp = function (vect1, scalar = 1) //returns vect1 with length scalar, unless vect1 is [0, 0]. defaults to unit vector
		{
			if (vectLength(vect1) != 0)
			{
				return vectScale(vect1, scalar / vectLength(vect1));
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
		
		vectGetComponent = function(vect1, vect2) //returns the component of vect1 in the vect2 direction (vector projection v1 on v2)
		{
			output = vectDotProduct(vect1, vect2); //do dot product
			
			output = vectScale(output, 1/sqr(vectLength(vect2))); //divide by length squared
			
			output = vectScale(vect2, vectLength(output)); //multiply by vect2 again
			
			return output;
		}
		
		vectAverage = function(vect1, vect2, weight = 0.5) //averages the two vectors passed into it, with optional weight towards 1st vector
		{
			output = [0, 0];
			
			output = vectSum(output, vectScale(vect1, weight));
			output = vectSum(output, vectScale(vect2, 1.0 - weight));
			
			return output;
		}
		
		vectRotateTo = function(vect1, vect2) //rotates vect1 to face the same direction as vect2 maybe UNTESTED
		{
			angle = vectAngle(vect2) - vectAngle(vect1);
			
			return vectRotate(vect1, angle);
		}
		
		vectScramble = function(vect1, scalar) //returns vector with endpoint randomized to point within a circle of radius (scalar)
		{
			vectModify = [random(scalar), 0]; //create vector with random radius
			vectModify = vectRotate(vectModify, random(360)); //rotate vector to random direction in a circle
			return vectSum(vect1, vectModify); 
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
		
		fillSlot = function(slotName, index, wepStruct) //fills slot with weapon name, marking it as full
		{			
			if (slotName == "main") //looks for right type of slot
			{
				if (partData[getPartIndex(equippedBody)].main[index] != -1) //makes sure slot is valid
				{
					partData[getPartIndex(equippedBody)].main[index] = wepStruct;
					return;
				}
			}
			if (slotName == "aux")
			{
				if (partData[getPartIndex(equippedBody)].aux[index] != -1)
				{
					partData[getPartIndex(equippedBody)].aux[index] = wepStruct;
					return;
				}
			}
			if (slotName == "def")
			{
				if (partData[getPartIndex(equippedBody)].def[index] != -1)
				{
					partData[getPartIndex(equippedBody)].def[index] = wepStruct;
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
		
		initalizePlayerLegs = function(name) //DEPRECATED
		{
			index = getPartIndex(name); //get data location
			instance_create_layer(600, 600, "PlayerThings", oLegs, partData[index]); //creates a legs object with proper data
		}
		
		initalizePlayerBody = function(name) //DEPRECATED
		{
			index = getPartIndex(name); //get data location
			instance_create_layer(0, 0, "PlayerThings", oBody, partData[index]); //creates a body object with proper data
		}
		
		initalizePlayerGun = function(name, key, index = -1) //DEPRECATED fills a slot in selected body's partData entries equipment array with the selected gun data
		{
			partIndex = getPartIndex(name); //stores the index of the globalData array entry for this part
			
			var dataStruct = variable_clone(partData[partIndex], 2); //duplicate data structure from the globalData array
			
			slotType = dataStruct.slotType; //stores the slot type of this equipment (main, aux, def)
			
			if (index != -1) //only initialize the gun if there is a valid slot to put it in
			{
				dataStruct.mountOffset = getMountOffset(slotType, index); //setup mount offset & equip weapon in slot
				
				dataStruct.fireKey = key; //setup weapon group
			
				fillSlot(slotType, index, dataStruct); //fills the designated slot with this weapon's name
				
				//instance_create_layer(600, 600, "PlayerThings", oGun, partData[partIndex]); //creates a gun object with proper data
			}
		}
		
		createPlayer = function(x, y) //turns data from partData into real objects in the game world, creating a full player at coords x, y
		{
			instance_create_layer(x, y, "PlayerThings", oLegs, partData[oGlobalData.getPartIndex(equippedLegs)]); //creates a leg object with the data from the data list
			instance_create_layer(x, y, "PlayerThings", oBody, partData[oGlobalData.getPartIndex(equippedBody)]); //creates a body object with the data from the data list
			
			//main slots
			for (var i = 0; i < array_length(oBody.main); i++)
			{
				if (typeof(oBody.main[i]) == "struct")
				{
					instance_create_layer(x, y, "PlayerThings", oGun, oBody.main[i]); //creates a gun with the data filled in during character creation
				}
			}
			
			//aux slots
			for (var i = 0; i < array_length(oBody.aux); i++)
			{
				if (typeof(oBody.aux[i]) == "struct")
				{
					instance_create_layer(x, y, "PlayerThings", oGun, oBody.aux[i]); //creates a gun with the data filled in during character creation
				}
			}
			
			//def slots
			for (var i = 0; i < array_length(oBody.def); i++)
			{
				if (typeof(oBody.def[i]) == "struct")
				{
					instance_create_layer(x, y, "PlayerThings", oGun, oBody.def[i]); //creates a gun with the data filled in during character creation
				}
			}
			
			//creates player lockbox and aim point 
			instance_create_layer(x, y, "PlayerThings", oLockBox);
			instance_create_layer(x, y, "PlayerThings", oAimPoint);
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
		
		drawTextFull = function(x, y, string, font, c1 = c_red, hAlign = fa_center, vAlign = fa_center, xScale = 1, yScale = 1, alpha = 1, draw_angle = 0, c2 = -1, c3 = -1, c4 = -1)
		{
			/*default properties
				no rescale
				red, no graident
				center align
				no angle
				no transparency
			*/
			if (c2 == -1 || c3 == -1 || c4 == -1) //handle default coloring
			{
				c2 = c1;
				c3 = c1;
				c4 = c1;
			}
			
			draw_set_halign(hAlign);
			draw_set_valign(vAlign);
			draw_set_font(font);
			
			draw_text_transformed_colour(x, y, string, xScale, yScale, draw_angle, c1, c2, c3, c4, alpha);
		}
}