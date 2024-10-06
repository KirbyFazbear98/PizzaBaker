//First, make the mod directory

directory_create(game_save_id+"/mods/"+newModName+"-converted")

directory_create(game_save_id+"/mods/"+newModName+"-converted/data")
directory_create(game_save_id+"/mods/"+newModName+"-converted/patch")

directory_create(game_save_id+"/mods/"+newModName+"-converted/data/lang/graphics")
directory_create(game_save_id+"/mods/"+newModName+"-converted/data/lang/fonts")
directory_create(game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop")

//Now find the xdelta patch
folder = file_find_first(game_save_id+"/temp/*", fa_directory);
file_find_close()
show_debug_message("Folder is "+folder)
poModDir = game_save_id+"/temp/"+folder
show_debug_message("poModDir is "+poModDir)
patch = file_find_first(poModDir+"/*.xdelta", fa_none);
file_copy(poModDir+"/"+patch, game_save_id+"/mods/"+newModName+"-converted/patch/"+newModName+".xdelta")
file_delete(patch)

folder = file_find_first(game_save_id+"/temp/*", fa_directory);
show_debug_message("Folder is "+folder)
poModDir = game_save_id+"/temp/"+folder
show_debug_message("poModDir is "+poModDir)
//Now Create a mod.ini based on info given
ini_open(game_save_id+"/mods/"+newModName+"-converted/mod.ini")
ini_write_string("Mod", "ModName", newModName)
ini_write_string("Mod", "ModAuthor", newModAuthor)
ini_write_string("Mod", "ModVersion", newModVersion)
ini_write_string("Patch", "data.win", newModName+".xdelta")
ini_close()

//Now find anything else for the mod
//Starting with a lang directory
if directory_exists(poModDir){
	directory_copy(poModDir, game_save_id+"/mods/"+newModName+"-converted/data", fa_none)
}
if directory_exists(poModDir+"/lang"){
	directory_copy(poModDir+"/lang", game_save_id+"/mods/"+newModName+"-converted/data/lang", fa_none)
}
//Screw You Peppina and your weird folder structure
if directory_exists(poModDir+"/langs/lang"){
	directory_copy(poModDir+"/langs/lang", game_save_id+"/mods/"+newModName+"-converted/data/lang", fa_none)
}
if directory_exists(poModDir+"/langs/lang/graphics"){
	directory_copy(poModDir+"/langs/lang/graphics", game_save_id+"/mods/"+newModName+"-converted/data/lang/graphics", fa_none)
}
if directory_exists(poModDir+"/langs/lang/fonts"){
	directory_copy(poModDir+"/langs/lang/fonts", game_save_id+"/mods/"+newModName+"-converted/data/lang/fonts", fa_none)
}
if directory_exists(poModDir+"/lang/graphics"){
	directory_copy(poModDir+"/lang/graphics", game_save_id+"/mods/"+newModName+"-converted/data/lang/graphics", fa_none)
}
if directory_exists(poModDir+"/lang/fonts"){
	directory_copy(poModDir+"/lang/fonts", game_save_id+"/mods/"+newModName+"-converted/data/lang/fonts", fa_none)
}
if directory_exists(poModDir+"/sound/Desktop"){
	directory_copy(poModDir+"/sound/Desktop", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop", fa_none)
}

//Now for any straglers
if file_exists(poModDir+"/english.txt"){
	file_copy(poModDir+"/english.txt", game_save_id+"/mods/"+newModName+"-converted/data/lang/english.txt")
}
if file_exists(poModDir+"/Master.bank"){
	file_copy(poModDir+"/Master.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/Master.bank")
}
if file_exists(poModDir+"/Master.strings.bank"){
	file_copy(poModDir+"/Master.strings.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/Master.strings.bank")
}
if file_exists(poModDir+"/music.bank"){
	file_copy(poModDir+"/music.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/music.bank")
}
if file_exists(poModDir+"/sfx.bank"){
	file_copy(poModDir+"/sfx.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/sfx.bank")
}

show_message("Mod Converted")
refresh_mods()
room_restart()