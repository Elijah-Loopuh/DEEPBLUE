for (var i = 0; i < 10; i ++) //visual particle effect
{
	instance_create_layer(x, y, "Instances", oSmokeParticle);
}



updateVars();

updateVectorMoveInput();

event_inherited(); //bundled movement

doFireControl();