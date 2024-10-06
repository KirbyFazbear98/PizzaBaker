scrollY += 32
if scrollY > scrollCap
	scrollY = scrollCap
	
camera_set_view_pos(view_camera[1], 0, 128+scrollY)