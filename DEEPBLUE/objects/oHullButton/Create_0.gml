id.depth = 0;

is_clicked = function()
{
	if (mouse_check_button_pressed(mb_left) && instance_place(mouse_x, mouse_y, id))
	{
		return true;
	}
	return false;
}