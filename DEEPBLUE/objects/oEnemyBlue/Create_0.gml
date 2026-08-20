event_inherited();

//hard set movement params
regularGrip = 0.75; //regular grip
regularSpeedCap = 15;
dragStatic = 0.15; //drag when no buttons held
dragDynamic = 0.0; //drag when movement buttons are held
hp = 100;

//ai control variables
standoff = 600; //distance the cycler will hold from player
tolerance = 100; //distance from standoff where the enemy won't correct it's distance
twitch = 25; //angle offset the enemy will use when getting back to standoff
rotationDirection = 1; //can be set to +1 or -1 to control direction of rotation
countdownMax = 15; //max seconds between direction switches
reverseCountdown = irandom(60 * countdownMax);

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
	
	vectMoveInput = oGlobalData.vectRotate(vectMoveInput, 75 * rotationDirection); //rotate vector to circle player
	
	if (oGlobalData.vectLength(vectMoveInput) > standoff + tolerance)
	{
		vectMoveInput = oGlobalData.vectRotate(vectMoveInput, (0 - twitch * rotationDirection)); //roate vector to close in on player
	}
	if (oGlobalData.vectLength(vectMoveInput) < standoff - tolerance)
	{
		vectMoveInput = oGlobalData.vectRotate(vectMoveInput, (0 + twitch * rotationDirection)); //roate vector to back off from player
	}
	
	vectMoveInput = oGlobalData.vectClamp(vectMoveInput);
	
	if (checkCollision() != 0) //reverse direction when hitting a wall
	{
		rotationDirection *= -1;
	}
}