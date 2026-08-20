event_inherited();

//hard set movement params
regularGrip = 1.0; //regular grip
regularSpeedCap = 25;
dragStatic = 0.15; //drag when no buttons held
dragDynamic = 0.0; //drag when movement buttons are held
hp = 100;

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

updateVectorMoveInput = function () //ai movement coding
{
	vectMoveInput = oGlobalData.vectSum(oGlobalData.vectInvert(vectPos), oBody.vectPosTarget);
	vectMoveInput = oGlobalData.vectClamp(vectMoveInput);
}