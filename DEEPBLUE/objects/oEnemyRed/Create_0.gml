id.depth = 800;

hpMax = 100;
hp = hpMax;
moveSpeed = 10;
damage = 10;

vectVelocity = [0, 0];
vectPos = [0, 0];
takeDamage = function(ammount) //take damage and die if out of hp
{
	hp -= ammount; //take damage number out of health value
	if (hp <= 0)
	{
		instance_destroy();
	}
}