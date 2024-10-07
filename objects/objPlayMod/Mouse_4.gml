var pizzaTowerMod, patchFile;
if (layer_get_visible(layer) == false)
    return;
audio_stop_all()
audio_play_sound(sndLaunchMod, 1, false)
directory_destroy(game_save_id + "/pt/")
file_copy((global.pizzaTower + "data.win"), (game_save_id + "/pt/patch/data.win.og"))
file_copy((working_directory + "patchTool/xdelta.exe"), (game_save_id + "/pt/patch/xdelta.exe"))
file_copy((working_directory + "patchTool/patch.bat"), (game_save_id + "/pt/patch/patch.bat"))
pizzaTowerMod = game_save_id + "pt/"
ini_open(global.modDir[global.currentMod] + "/mod.ini")
show_debug_message("Loading Data from " + global.modDir[global.currentMod] + "/mod.ini")
patchFile = ini_read_string("Patch", "data.win", "")
if (patchFile == "Put xdelta filename here")
{
    show_debug_message("This appears to be the example mod. This is not a real mod, so I'm not gonna even TRY and load it.")
    return;
}
if (patchFile == "")
{
    show_debug_message("Malformed mod.ini, make sure you specify the patch file.")
    return;
}

//Thanks EmeraldMan for the Optimisations for loading the game, that was cool of him.
show_debug_message("Patch is /patch/" + patchFile)
file_copy((global.modDir[global.currentMod] + "/patch/" + patchFile), (game_save_id + "/pt/patch/patch.xdelta"))
show_debug_message("Patching data.win")
gml_Script_execute_shell_simple("cmd.exe", ("/C " + game_save_id + "/pt/patch/patch.bat"))
show_debug_message("Copying Pizza Tower")
file_copy((global.pizzaTower + "PizzaTower.exe"), (game_save_id + "/pt/PizzaTower.exe"))
file_copy((global.pizzaTower + "credits.txt"), (game_save_id + "/pt/credits.txt"))
file_copy((global.pizzaTower + "noisecredits.txt"), (game_save_id + "/pt/noisecredits.txt"))
file_copy((global.pizzaTower + "fmod.dll"), (game_save_id + "/pt/fmod.dll"))
file_copy((global.pizzaTower + "fmod-gamemaker.dll"), (game_save_id + "/pt/fmod-gamemaker.dll"))
file_copy((global.pizzaTower + "fmodstudio.dll"), (game_save_id + "/pt/fmodstudio.dll"))
file_copy((global.pizzaTower + "gameframe_x64.dll"), (game_save_id + "/pt/gameframe_x64.dll"))
file_copy((global.pizzaTower + "options.ini"), (game_save_id + "/pt/options.ini"))
directory_create(pizzaTowerMod + "lang/fonts")
directory_copy((global.pizzaTower + "lang/fonts"), (pizzaTowerMod + "lang/fonts"), 0)
directory_create(pizzaTowerMod + "lang/graphics")
directory_copy((global.pizzaTower + "lang/graphics"), (pizzaTowerMod + "lang/graphics"), 0)
directory_copy((global.pizzaTower + "lang"), (pizzaTowerMod + "lang"), 0)
directory_create(pizzaTowerMod + "sound/Desktop")
directory_copy((global.pizzaTower + "sound/Desktop"), (pizzaTowerMod + "sound/Desktop"), 0)
show_debug_message("Updating " + game_save_id + "pt/")
directory_copy((global.modDir[global.currentMod] + "/data/"), (game_save_id + "pt/"), 0)
show_debug_message("Updating " + pizzaTowerMod + "sound/Desktop")
if directory_exists(global.modDir[global.currentMod] + "/data/sound/Desktop")
    directory_copy((global.modDir[global.currentMod] + "/data/sound/Desktop"), (pizzaTowerMod + "sound/Desktop"), 0)
show_debug_message("Updating " + pizzaTowerMod + "lang/fonts")
if directory_exists(global.modDir[global.currentMod] + "/data/lang/fonts")
    directory_copy((global.modDir[global.currentMod] + "/data/lang/fonts"), (pizzaTowerMod + "lang/fonts"), 0)
show_debug_message("Updating " + pizzaTowerMod + "lang/graphics")
if directory_exists(global.modDir[global.currentMod] + "/data/lang/graphics")
    directory_copy((global.modDir[global.currentMod] + "/data/lang/graphics"), (pizzaTowerMod + "lang/graphics"), 0)
show_debug_message("Updating " + pizzaTowerMod + "lang")
if directory_exists(global.modDir[global.currentMod] + "/data/lang")
    directory_copy((global.modDir[global.currentMod] + "/data/lang"), (pizzaTowerMod + "lang"), 0)
alarm[0] = 60
