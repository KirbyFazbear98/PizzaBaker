newScrollCap = 0;

if hasMods = false{
	instance_destroy()
	exit
}


var i = 0;
repeat(array_length(modName)){
	tehMod = instance_create_depth(x, y+(110*i), depth, objMod)
	tehMod.Id = i
	i += 1
	newScrollCap += 110
}
layer_set_visible("Assets_3", false)
alarm[0] = 1

instance_destroy()