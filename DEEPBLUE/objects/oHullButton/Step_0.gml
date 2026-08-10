if (is_clicked())
{
	oGlobalData.equippedBody = body;
	oGlobalData.equippedLegs = legs;
	room_goto(rSlotScreen);
}

show_debug_message(mouse_check_button_pressed(mb_left));
show_debug_message(instance_place(mouse_x, mouse_y, id));