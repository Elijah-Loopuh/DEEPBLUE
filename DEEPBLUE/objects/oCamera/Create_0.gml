camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);


zoomTarget = 1; //records target zoom

zoomCurrent = 1; //track current zoom

zoomSmooth = 1;

zoomSpeed = 0.03; //the speed that zoomsmooth changes at

zoomSpeed2 = 0.05 //percentage of the difference between zoomsmooth and zoomCurrent that zoomCurrent changes by every frame