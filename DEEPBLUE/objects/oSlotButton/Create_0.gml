font = fPixelFont;

//text = "PLACEHOLDER";

hAlign = fa_center;
vAlign = fa_center;

id.depth = 0;

is_clicked = function()
{
	if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id))
	{
		return true;
	}
	return false;
}