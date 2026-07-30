oGlobalData.initalizePlayerLegs(oGlobalData.equippedLegs); //create legs
oGlobalData.initalizePlayerBody(oGlobalData.equippedBody); //create body

for (i = 0; i < array_length(oGlobalData.equippedAux); i ++) //create auxGuns
{
	oGlobalData.initalizePlayerGun(oGlobalData.equippedAux[i]);
}