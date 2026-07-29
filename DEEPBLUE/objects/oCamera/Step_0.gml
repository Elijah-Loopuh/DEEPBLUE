//Fullscreen toggle
if keyboard_check_pressed(vk_f8) 
{ 
	window_set_fullscreen( !window_get_fullscreen() )	
}

//Exit if there is no player
if !instance_exists(oLegs) exit;

//Get camera size
camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);

//Get camera target coordinates
var camX = oLegs.x - camWidth/2;
var camY = oLegs.y - camHeight/2;

//Constrain cam to room borders
camX = clamp(camX, 0, room_width - camWidth)
camY = clamp(camY, 0, room_height - camHeight);

camera_set_view_pos(view_camera[0], camX, camY); //go to target coords