if (is_clicked())
{
	oGlobalData.currentSlotData.slotType = type;
	oGlobalData.currentSlotData.slotIndex = index;
	room_goto(rGunScreen);
}