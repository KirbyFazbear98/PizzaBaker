if layer_get_visible(layer) = false
	exit

audio_stop_all()
audio_play_sound(sndLaunchMod, 1, false)

directory_destroy(game_save_id+"/pt/")

file_copy(pizzaTower+"data.win", game_save_id+"/pt/patch/data.win.og")
file_copy(working_directory+"patchTool/xdelta.exe", game_save_id+"/pt/patch/xdelta.exe")
file_copy(working_directory+"patchTool/patch.bat", game_save_id+"/pt/patch/patch.bat")

var pizzaTowerMod = game_save_id+"pt/";

var patchFile;
ini_open(modDir[currentMod]+"/mod.ini")
show_debug_message("Loading Data from "+modDir[currentMod]+"/mod.ini")
patchFile = ini_read_string("Patch", "data.win", "")
if patchFile = "Put xdelta filename here"{
	show_message("This appears to be the example mod. This is not a real mod, so I'm not gonna even TRY and load it.")
	exit
}
if patchFile = ""{
	show_message("Malformed mod.ini, make sure you specify the patch file.")
	exit
}
show_debug_message("Patch is "+"/patch/"+patchFile)
file_copy(modDir[currentMod]+"/patch/"+patchFile, game_save_id+"/pt/patch/patch.xdelta")
show_debug_message("Patching data.win")
execute_shell_simple("cmd.exe", "/C "+game_save_id+"/pt/patch/patch.bat")
show_debug_message("Copying Pizza Tower")
directory_copy(pizzaTower, game_save_id+"/pt/", fa_none)
directory_create(pizzaTowerMod+"lang/fonts")
directory_copy(pizzaTower+"lang/fonts", pizzaTowerMod+"lang/fonts", fa_none)
directory_create(pizzaTowerMod+"lang/graphics")
directory_copy(pizzaTower+"lang/graphics", pizzaTowerMod+"lang/graphics", fa_none)
directory_copy(pizzaTower+"lang", pizzaTowerMod+"lang", fa_none)
directory_create(pizzaTowerMod+"sound/Desktop")
directory_copy(pizzaTower+"sound/Desktop", pizzaTowerMod+"sound/Desktop", fa_none)
show_debug_message("Updating "+game_save_id+"pt/")
directory_copy(modDir[currentMod]+"/data/", game_save_id+"pt/", fa_none)
show_debug_message("Updating "+pizzaTowerMod+"sound/Desktop")
if directory_exists(modDir[currentMod]+"/data/sound/Desktop")
	directory_copy(modDir[currentMod]+"/data/sound/Desktop", pizzaTowerMod+"sound/Desktop", fa_none)
show_debug_message("Updating "+pizzaTowerMod+"lang/fonts")
if directory_exists(modDir[currentMod]+"/data/lang/fonts")
	directory_copy(modDir[currentMod]+"/data/lang/fonts", pizzaTowerMod+"lang/fonts", fa_none)
show_debug_message("Updating "+pizzaTowerMod+"lang/graphics")
if directory_exists(modDir[currentMod]+"/data/lang/graphics")
	directory_copy(modDir[currentMod]+"/data/lang/graphics", pizzaTowerMod+"lang/graphics", fa_none)
show_debug_message("Updating "+pizzaTowerMod+"lang")
if directory_exists(modDir[currentMod]+"/data/lang")
	directory_copy(modDir[currentMod]+"/data/lang", pizzaTowerMod+"lang", fa_none)
file_delete(pizzaTowerMod+"steam_api64.dll")
file_delete(pizzaTowerMod+"Steamworks_x64.dll")
alarm[0] = 5*60
