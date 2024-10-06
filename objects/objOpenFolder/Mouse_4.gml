if layer_get_visible(layer) = false
	exit
show_debug_message("Mod Directory is "+modDir[currentMod])
audio_play_sound(sndSelect, 1, false) 
execute_shell_simple(modDir[currentMod], "", "explore")