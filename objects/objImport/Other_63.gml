var _id, _stat;
_id = ds_map_find_value(async_load, "id");
if (_id == msg)
{
    if (ds_map_find_value(async_load, "status"))
    {
        modNameMsg = get_string_async("Enter a name for this mod", "")
    }
}
else if (_id == modNameMsg)
{
    if (ds_map_find_value(async_load, "status"))
    {
        if (ds_map_find_value(async_load, "result") != "")
        {
            newModName = ds_map_find_value(async_load, "result");
			modAuthorMsg = get_string_async("Enter an Author for this mod", "")
        }
    }
}
else if (_id == modAuthorMsg)
{
    if (ds_map_find_value(async_load, "status"))
    {
        if (ds_map_find_value(async_load, "result") != "")
        {
            newModAuthor = ds_map_find_value(async_load, "result");
			modVersionMsg = get_string_async("Enter a Version for this mod", "")
        }
    }
}
else if (_id == modVersionMsg)
{
    if (ds_map_find_value(async_load, "status"))
    {
        if (ds_map_find_value(async_load, "result") != "")
        {
            newModVersion = ds_map_find_value(async_load, "result");
			alarm[1] = 1
        }
    }
}