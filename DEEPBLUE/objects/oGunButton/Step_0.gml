type = oGlobalData.partData[oGlobalData.getPartIndex(gun)].slotType; //set type from the assigned gun

if (type != oGlobalData.currentSlotData.slotType) //destroy if not the type of the slot button that was clicked
{
	instance_destroy(id);
}

if(is_hovered())
{
	if (keyboard_check_pressed( ord("Q") ))
	{
		oGlobalData.initalizePlayerGun(gun, ord("Q"), oGlobalData.currentSlotData.slotIndex);
		room_goto(rSlotScreen);
	}
	if (keyboard_check_pressed( ord("E") ))
	{
		oGlobalData.initalizePlayerGun(gun, ord("E"), oGlobalData.currentSlotData.slotIndex);
		room_goto(rSlotScreen);
	}
	if (mouse_check_button_pressed(mb_left))
	{
		oGlobalData.initalizePlayerGun(gun, mb_left, oGlobalData.currentSlotData.slotIndex);
		room_goto(rSlotScreen);
	}
	if (mouse_check_button_pressed(mb_right))
	{
		oGlobalData.initalizePlayerGun(gun, mb_right, oGlobalData.currentSlotData.slotIndex);
		room_goto(rSlotScreen);
	}
}