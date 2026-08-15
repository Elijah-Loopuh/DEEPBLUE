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

moveSpeed = 5;

dodgeCooldown = 60*3;
dodgeCooldownTracker = dodgeCooldown;

dodgeDuration = 60*1;
dodgeDurationTracker = 0;

vectPos = [0, 0];
vectVelocity = [0, 0];