if file_exists(game_save_id+"/pt/patch/data.win"){
	show_debug_message("Updating data.win")
	file_copy(game_save_id+"/pt/patch/data.win", game_save_id+"/pt/data.win") 
	alarm[1] = 5*60
}else{
	alarm[0] = 3*60
}	
