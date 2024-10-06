export = zip_create()
show_debug_message("Exporting "+modDir[currentMod]+" as .pbmod")

var files = [];
var i = 0;
var file_name = file_find_first(modDir[currentMod]+"/*", fa_none);

while (file_name != "")
{
    array_push(files, file_name);
	zip_add_file(export, files[i], file_name)
    file_name = file_find_next();
	i += 1
}

file_find_close();

dest = get_save_filename_ext("PizzaBaker Mod Archive|*.pbmod", modDir[currentMod]+".pbmod", modDir[currentMod], "Export .pbmod Archive.")
if !(dest = "")
	zip_save(export, dest)