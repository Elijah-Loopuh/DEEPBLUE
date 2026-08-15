//manage cursor display
window_set_cursor(cr_none);
if (array_contains(oGlobalData.uiList, room))
{
	cursor_sprite = sPointOfAim;
}
if (array_contains(oGlobalData.roomList, room))
{
	cursor_sprite = -1;
}