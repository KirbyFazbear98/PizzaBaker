if (ds_map_find_value(async_load, "id") == request_id)
{
    var _status = ds_map_find_value(async_load, "status");
    if (_status == 0)
    {
        var _path = ds_map_find_value(async_load, "result");
        var _files = zip_unzip(game_save_id+"downloads/dl.zip", game_save_id+"mods");
        if (_files > 0)
        {
			refresh_mods()
            room_goto(rmMods)
        }
    }
	if (_status == 1){
			
		sizeTotal = ds_map_find_value(async_load, "contentLength")
		sizeOnDisk = ds_map_find_value(async_load, "sizeDownloaded")
		
	}
}