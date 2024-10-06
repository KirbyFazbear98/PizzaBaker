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