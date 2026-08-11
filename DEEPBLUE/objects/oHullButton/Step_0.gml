if (is_clicked())
{
	oGlobalData.equippedBody = body;
	oGlobalData.equippedLegs = legs;
	room_goto(rSlotScreen);
}