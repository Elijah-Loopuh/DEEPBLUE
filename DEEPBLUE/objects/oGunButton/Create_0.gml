font = fPixelFont;

hAlign = fa_center;
vAlign = fa_center;

gun = "middle mg"; //name of the gun that the button will put in the slot (placeholder value of 1st gun added to game)

id.depth = 0;

is_hovered = function()
{
	if (position_meeting(mouse_x, mouse_y, id))
	{
		return true;
	}
	return false;
}