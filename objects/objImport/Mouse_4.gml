audio_play_sound(sndSelect, 1, false)
directory_destroy(game_save_id+"/temp")
tehZip = get_open_filename_ext("PizzaBaker or Pizza Oven Mod|*.zip;*.pbmod", "", "%homepath%", "Import a PizzaBaker Mod")

if !(tehZip = ""){
	zip_unzip(tehZip, game_save_id+"/temp")
	if (directory_exists(game_save_id+"/temp")){
	    folder = file_find_first(game_save_id+"/temp/*", fa_directory);
	    file_find_close();
		if file_exists(game_save_id+"/temp/"+folder+"/mod.ini"){
			zip_unzip(tehZip, game_save_id+"/mods")
			refresh_mods()
			room_restart()
		}else{
			msg = show_question_async("It appears you have imported a Pizza Oven Mod. You want me to convert it to a PizzaBaker Mod?")	
		}
	}
}