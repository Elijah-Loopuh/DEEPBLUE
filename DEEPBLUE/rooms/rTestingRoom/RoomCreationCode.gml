oGlobalData.initalizePlayerLegs(oGlobalData.equippedLegs); //create legs
oGlobalData.initalizePlayerBody(oGlobalData.equippedBody); //create body

for (var i = 0; i < array_length(oGlobalData.equippedGuns); i ++) //create auxGuns
{
	oGlobalData.initalizePlayerGun(oGlobalData.equippedGuns[i][0], oGlobalData.equippedGuns[i][1]);
}