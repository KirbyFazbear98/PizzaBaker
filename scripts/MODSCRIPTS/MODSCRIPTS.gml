// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function loader_start(){
	globalvar currentMod;
	
	currentMod = -1
	
}

function gen_reg_file(){
	regFile = file_text_open_write(game_save_id+"gbData.reg")
	file_text_write_string(regFile, "Windows Registry Editor Version 5.00")
	file_text_writeln(regFile)
	file_text_writeln(regFile)
	file_text_write_string(regFile, "[HKEY_CLASSES_ROOT\\PizzaBaker]")
	file_text_writeln(regFile)
	file_text_write_string(regFile, "@="+"\"URL:pizzabaker\"")
	file_text_writeln(regFile)
	file_text_write_string(regFile, "\"URL Protocol\"=\"\"")
	file_text_writeln(regFile)
	file_text_writeln(regFile)
	file_text_write_string(regFile, "[HKEY_CLASSES_ROOT\\PizzaBaker\\shell]")
	file_text_writeln(regFile)
	file_text_writeln(regFile)
	file_text_write_string(regFile, "[HKEY_CLASSES_ROOT\\PizzaBaker\\shell\\open]")
	file_text_writeln(regFile)
	file_text_writeln(regFile)
	file_text_write_string(regFile, "[HKEY_CLASSES_ROOT\\PizzaBaker\\shell\\open\\command]")
	file_text_writeln(regFile)
	var regDir;
	regDir = string_replace_all(working_directory+"PizzaBaker.exe", "\\", "\\\\")
	file_text_write_string(regFile, "@="+"\"\\\""+regDir+"\\\" -gbImport \\\"%1\\\"\"")
	file_text_writeln(regFile)
	file_text_writeln(regFile)
	file_text_close(regFile)
	
}

function refresh_mods(){

	globalvar hasMods;
	hasMods = false

	globalvar modName;
	globalvar modAuthor;
	globalvar modVersion;
	globalvar modIcon;
	globalvar modThumb;
	globalvar modDir;

	var files = [];
	var i = 0;
	var file_name = file_find_first("mods/*", fa_directory);

	while (file_name != "")
	{
	    array_push(files, file_name);

	    file_name = file_find_next();
		
		hasMods = true

		modDir[i] = game_save_id+"mods/"+files[i]
		ini_open("mods/"+files[i]+"/mod.ini")
		show_debug_message("Loading "+files[i]+" Mod INI")
		modName[i] = ini_read_string("Mod", "ModName", "Name Missing")
		show_debug_message(files[i]+" Mod Name is "+modName[i])
		modAuthor[i] = ini_read_string("Mod", "ModAuthor", "Name Missing")
		show_debug_message(files[i]+" Mod Author is "+modAuthor[i])
		modVersion[i] = ini_read_string("Mod", "ModVersion", "vX.X")
		show_debug_message(files[i]+" Mod Version is "+modAuthor[i])
		ini_close()
		
		
		modIcon[i] = "mods/"+files[i]+"/icon.png"
		modThumb[i] = "mods/"+files[i]+"/thumb.png"
		
		
		show_debug_message("Directory "+files[i]+" has been loaded.")
		i += 1
	}

	file_find_close();
	show_debug_message("Directory Loading Done.")

	}
	
function directory_copy(argument0, argument1, argument2){

/// file_copy_dir(source, target, attributes)
// Copies contents from source directory to target directory.
// Add fa_directory to attributes for recursive copying.
var fname, i, file, files, from, to;
// create directory if it doesn't exist yet:
if (!directory_exists(argument1)) directory_create(argument1)
// push matching files into array:
// (has to be done separately due to possible recursion)
files = 0
for (fname = file_find_first(argument0 + "/*.*", argument2); fname != ""; fname = file_find_next()) {
    // don't include current/parent directory "matches":
    if (fname == ".") continue
    if (fname == "..") continue
    // push file into array
    file[files] = fname
    files += 1
}
file_find_close()
// process found files:
i = 0
repeat (files) {
    fname = file[i]
    i += 1
    from = argument0 + "/" + fname
    to = argument1 + "/" + fname
    if (file_attributes(from, fa_directory)) { // note: in GM:S+, prefer directory_exists(from)
        file_copy_dir(from, to, argument2) // recursively copy directories
    } else {
        file_copy(from, to) // copy files as normal
    }
}
	
	
}
	
function cl_params(){
	var p_num;
	globalvar importURL;
	p_num = parameter_count();
	if (p_num > 0)
	{
	    var i;
	    for (i = 0; i < p_num; i += 1)
	    {
	        p_string[i] = parameter_string(i + 1);
			if p_string[i] = "-gbImport"{
				importURL = parameter_string(i + 2);
				importURL = string_replace(importURL, "pizzabaker:", "")
				room_goto(rmLoadMod)
			}
	    }
	}	
	
	
}
	
function fileFind(directory, file, fileList) {
    var _folder = directory;
    var _fileList = fileList;
    var _queue = ds_queue_create();

    ds_queue_enqueue(_queue, _folder);

    while (!ds_queue_empty(_queue)) {
        var currentFolder = ds_queue_dequeue(_queue);

        var filesInFolder = file_find_first(currentFolder + file, 0);
        while (filesInFolder != "") {
            if (!directory_exists(currentFolder + filesInFolder)) {
                ds_list_add(_fileList, currentFolder + filesInFolder);
                show_debug_message("Added file: " + currentFolder + filesInFolder);
            }
            filesInFolder = file_find_next();
        }

        var subfolders = file_find_first(currentFolder + "*", fa_directory);
        while (subfolders != "") {
            if (subfolders != "." and subfolders != ".." and directory_exists(currentFolder + subfolders)) {
                ds_queue_enqueue(_queue, currentFolder + subfolders + "/");
                show_debug_message("Enqueued subfolder: " + currentFolder + subfolders + "/");
            }
            subfolders = file_find_next();
        }
    }
    ds_queue_destroy(_queue);
}

function legacyImport(){
	var poRoot;
	
	directory_create(game_save_id+"/mods/"+newModName+"-converted")

	directory_create(game_save_id+"/mods/"+newModName+"-converted/data")
	directory_create(game_save_id+"/mods/"+newModName+"-converted/patch")

	directory_create(game_save_id+"/mods/"+newModName+"-converted/data/lang/graphics")
	directory_create(game_save_id+"/mods/"+newModName+"-converted/data/lang/fonts")
	directory_create(game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop")
	
	//Find the "root" of the mod
	var check;
	check = file_find_first(game_save_id+"/temp/*.xdelta", fa_none)
	if check = ""{
		folder = file_find_first(game_save_id+"/temp/*", fa_directory);
		file_find_close()
		check = file_find_first(game_save_id+"/temp/"+folder+"/*.xdelta", fa_none)
		if check = ""{
			show_message("No XDelta Patch was found.")
			exit
		}else{
			poRoot = game_save_id+"/temp/"+folder+"/"
		}
	}else{
		poRoot = game_save_id+"/temp/"
	}
	show_debug_message("Pizza Oven Mod Root is "+string(poRoot))
	
	//Now find the xdelta patch
	patch = file_find_first(poRoot+"/*.xdelta", fa_none);
	file_copy(poRoot+"/"+patch, game_save_id+"/mods/"+newModName+"-converted/patch/"+newModName+".xdelta")
	file_delete(patch)
	
	//Now Create a mod.ini based on info given
	ini_open(game_save_id+"/mods/"+newModName+"-converted/mod.ini")
	ini_write_string("Mod", "ModName", newModName)
	ini_write_string("Mod", "ModAuthor", newModAuthor)
	ini_write_string("Mod", "ModVersion", newModVersion)
	ini_write_string("Patch", "data.win", newModName+".xdelta")
	ini_close()
	
	//Now find anything else for the mod
	//Starting with a lang directory
	if directory_exists(poRoot){
		directory_copy(poRoot, game_save_id+"/mods/"+newModName+"-converted/data", fa_none)
	}
	if directory_exists(poRoot+"/lang"){
		directory_copy(poRoot+"/lang", game_save_id+"/mods/"+newModName+"-converted/data/lang", fa_none)
	}
	//Screw You Peppina and your weird folder structure
	if directory_exists(poRoot+"/langs/lang"){
		directory_copy(poRoot+"/langs/lang", game_save_id+"/mods/"+newModName+"-converted/data/lang", fa_none)
	}
	if directory_exists(poRoot+"/langs/lang/graphics"){
		directory_copy(poRoot+"/langs/lang/graphics", game_save_id+"/mods/"+newModName+"-converted/data/lang/graphics", fa_none)
	}
	if directory_exists(poRoot+"/langs/lang/fonts"){
		directory_copy(poRoot+"/langs/lang/fonts", game_save_id+"/mods/"+newModName+"-converted/data/lang/fonts", fa_none)
	}
	if directory_exists(poRoot+"/lang/graphics"){
		directory_copy(poRoot+"/lang/graphics", game_save_id+"/mods/"+newModName+"-converted/data/lang/graphics", fa_none)
	}
	if directory_exists(poRoot+"/lang/fonts"){
		directory_copy(poRoot+"/lang/fonts", game_save_id+"/mods/"+newModName+"-converted/data/lang/fonts", fa_none)
	}
	if directory_exists(poRoot+"/sound/Desktop"){
		directory_copy(poRoot+"/sound/Desktop", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop", fa_none)
	}
	//ELM Support
	if directory_exists(poRoot+"/EggsLapMod"){
		directory_copy(poRoot+"/EggsLapMod", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/EggsLapMod", fa_none)
	}
	

	//Now for any straglers
	if file_exists(poRoot+"/english.txt"){
		file_copy(poRoot+"/english.txt", game_save_id+"/mods/"+newModName+"-converted/data/lang/english.txt")
	}
	if file_exists(poRoot+"/Master.bank"){
		file_copy(poRoot+"/Master.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/Master.bank")
	}
	if file_exists(poRoot+"/Master.strings.bank"){
		file_copy(poRoot+"/Master.strings.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/Master.strings.bank")
	}
	if file_exists(poRoot+"/music.bank"){
		file_copy(poRoot+"/music.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/music.bank")
	}
	if file_exists(poRoot+"/sfx.bank"){
		file_copy(poRoot+"/sfx.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/sfx.bank")
	}
	//Also the PTFSPRO Banks, AFOM uses these
	if file_exists(poRoot+"/mod-music.bank"){
		file_copy(poRoot+"/mod-music.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/mod-music.bank")
	}
	if file_exists(poRoot+"/mod-sfx.bank"){
		file_copy(poRoot+"/mod-sfx.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/mod-sfx.bank")
	}
	//Azu Tower is also weird...
	if file_exists(game_save_id+"/temp/mod-music.bank"){
		file_copy(game_save_id+"/temp/mod-music.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/mod-music.bank")
	}
	if file_exists(game_save_id+"/temp/mod-sfx.bank"){
		file_copy(game_save_id+"/temp/mod-sfx.bank", game_save_id+"/mods/"+newModName+"-converted/data/sound/Desktop/mod-sfx.bank")
	}
	
	
}

function legacyImport_old(){
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
	
}