scrollY -= 32
if scrollY < 0
	scrollY = 0
	
camera_set_view_pos(view_camera[1], 0, 128+scrollY)