loader_start()
gen_reg_file()
refresh_mods()

globalvar pizzaTower;
if file_exists(game_save_id+"loaderData.dta"){
	file = file_text_open_read(game_save_id+"loaderData.dta")
	pizzaTower = file_text_read_string(file)
	file_text_close(file)
}else{
	show_message("Please Specify where Pizza Tower is installed.")
	pizzaTower = get_open_filename_ext("Pizza Tower Executable|PizzaTower.exe", "PizzaTower.exe", "C:\Program Files (x86)\Steam\steamapps\common\Pizza Tower", "Select your Pizza Tower Executable")
	pizzaTower = string_delete(pizzaTower, string_length(pizzaTower)-(string_length("PizzaTower.ex")), string_length("PizzaTower.exee"))
	file = file_text_open_write(game_save_id+"loaderData.dta")
	file_text_write_string(file, pizzaTower)
	file_text_close(file)
}



room_goto_next()
cl_params()