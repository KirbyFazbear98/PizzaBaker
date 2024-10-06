draw_self()
if file_exists(modIcon[Id]){
	if !(tehIcon = sprFallbackIcon)
		sprite_delete(tehIcon)
	tehIcon = sprite_add(modIcon[Id], 0, false, false, 0, 0)
}else
	tehIcon = sprFallbackIcon
draw_sprite(tehIcon, 0, x+11, y+7)

draw_set_font(fntMainFont)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_text(x+104, y+7, modName[Id]+"\nBy "+modAuthor[Id]+"\n"+modVersion[Id])