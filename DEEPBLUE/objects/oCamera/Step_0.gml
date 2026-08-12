
/*
show_debug_message("oCamera: currentSlotData, slotType: " + oGlobalData.currentSlotData.slotType);
show_debug_message("oCamera: currentSlotData, slotIndex: " + string(oGlobalData.currentSlotData.slotIndex));

//show_debug_message("oCamera: mainSlotData: " + string(oGlobalData.partData[oGlobalData.getPartIndex(oGlobalData.equippedBody)].main));
show_debug_message("oCamera: auxSlotData: " + string(oGlobalData.partData[oGlobalData.getPartIndex(oGlobalData.equippedBody)].aux));
//show_debug_message("oCamera: defSlotData: " + string(oGlobalData.partData[oGlobalData.getPartIndex(oGlobalData.equippedBody)].def));
show_debug_message("\n XXXXXXXXXX \n")
/**/

//Fullscreen toggle
if keyboard_check_pressed(vk_f8) 
{ 
	window_set_fullscreen( !window_get_fullscreen() )	
}

//Exit if there is no player
if !instance_exists(oLegs)
{
	//show_debug_message("noPlayer");
	camWidth = camera_get_view_width(view_camera[0]);
	camHeight = camera_get_view_height(view_camera[0]);


	//Get camera target coordinates
	var camX = room_width/2 - camWidth/2;
	var camY = room_height/2 - camHeight/2;

	camera_set_view_pos(view_camera[0], camX, camY); //go to target coords
	
	exit;
}

//Get camera size

{ //smooth zooming
	zoomTarget = 1 + (0.04 * oGlobalData.vectLength(oLegs.vectVelocity));

	if (zoomTarget > zoomSmooth)
	{
		zoomSmooth += zoomSpeed;
	}
	if (zoomTarget < zoomSmooth)
	{
		zoomSmooth -= zoomSpeed;
	}
	if (abs(zoomTarget-zoomSmooth) < zoomSpeed) //anti flutter system
	{
		zoomSmooth = zoomTarget;
	}

	zoomCurrent += zoomSpeed2 * (zoomSmooth - zoomCurrent);
}

camera_set_view_size(view_camera[0], view_wport[0] * zoomCurrent, view_hport[0] * zoomCurrent); //set camera zoom to zoomsmooth

camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);

//Get camera target coordinates
var vectPlayerPos = [oLegs.x, oLegs.y];
var vectMousePos = [mouse_x, mouse_y];

//average them together
var vectCamTarget = oGlobalData.vectAverage(vectPlayerPos, vectMousePos, 0.55);

//account for cam width
vectCamTarget = oGlobalData.vectSum(vectCamTarget, [- camWidth/2, - camHeight/2]);

//set cam to a position
x += (vectCamTarget[0] - x) / 3;
y += (vectCamTarget[1] - y) / 3;


camera_set_view_pos(view_camera[0], x, y); //go to target coords