//Fullscreen toggle
if keyboard_check_pressed(vk_f8) 
{ 
	window_set_fullscreen( !window_get_fullscreen() )	
}

//Exit if there is no player
if !instance_exists(oLegs) exit;

//Get camera size


zoomTarget = 1 + (0.04 * oGlobalData.vectLength(oLegs.vectVelocity));

zoomSpeed = oGlobalData.symmetricalSQRT(zoomTarget - zoomSmooth) / 30;

zoomSmooth += zoomSpeed;

if (abs(zoomTarget-zoomSmooth) < zoomSpeed) //snap to target zoom if closer than one step
{
	zoomSmooth = zoomTarget;
}

camera_set_view_size(view_camera[0], view_wport[0] * zoomSmooth, view_hport[0] * zoomSmooth);

camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);


//Get camera target coordinates
var camX = oLegs.x - camWidth/2;
var camY = oLegs.y - camHeight/2;

//Constrain cam to room borders
camX = clamp(camX, 0, room_width - camWidth)
camY = clamp(camY, 0, room_height - camHeight);


camera_set_view_pos(view_camera[0], camX, camY); //go to target coords