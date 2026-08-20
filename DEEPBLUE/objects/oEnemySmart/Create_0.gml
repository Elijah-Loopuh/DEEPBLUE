// Inherit the parent event
event_inherited();

rocketData = 
{
	spread : 180,
	angle : 0, 
	vectVelocity : [1.0, 0], 
	tag : "enemy", 
	damage: 10
}


//hard set movement params
regularGrip = 0.5; //regular grip
regularSpeedCap = 20;
dragStatic = 0.10; //drag when no buttons held
dragDynamic = 0.0; //drag when movement buttons are held
hp = 100;

//ai control variables
standoff = 1000; //distance the cycler will hold from player
tolerance = 100; //distance from standoff where the enemy won't correct it's distance
attackCooldownMaster = 60*3; //frames between attacks
attackCooldown = attackCooldownMaster;

//variable assigning
grip = regularGrip; //rate of change of vectVelocity axis under normal conditions
speedCap = regularSpeedCap; //tracks current speed cap
drag = dragStatic; //fraction d/1 of speed lost every 
animationSpeed = 1/45; //multiplier from vectVelocity scale to animation fps

updateVars = function() //updates variables
{
	speedCap = regularSpeedCap;
	underSpeed = oGlobalData.vectLength(vectVelocity) <= speedCap; //tracks if player has control of the mech
	keyMove = (oGlobalData.vectLength(vectMoveInput) > 0);
	vectPos = [x, y];
}

updateVectorMoveInput = function() //ai movement coding
{
	vectMoveInput = oGlobalData.vectSum(oGlobalData.vectInvert(vectPos), oBody.vectPosTarget); //create vector pointing from enemy to target
	
	
	if (oGlobalData.vectLength(vectMoveInput) > standoff + tolerance) //if too far, approach
	{
		//do nothing, vector is already set up to approach
	}
	if (oGlobalData.vectLength(vectMoveInput) < standoff - tolerance)
	{
		vectMoveInput = oGlobalData.vectScale(vectMoveInput, -1); //if too close, back off from player.
	}
	if (abs(oGlobalData.vectLength(vectMoveInput) - standoff) < tolerance) //if in tolerance range of standoff distance
	{
		vectMoveInput = oGlobalData.vectZero;
	}
	
	vectMoveInput = oGlobalData.vectClamp(vectMoveInput);
}

doFireControl = function() //handles enemy attacks
{
	if (attackCooldown > 0)
	{
		attackCooldown -= 1;
	}
	else
	{
		attackCooldown = attackCooldownMaster;
		instance_create_layer(x, y, "Instances", oSmallRocket, rocketData)
	}
}