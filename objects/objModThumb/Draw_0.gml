if file_exists(modThumb[currentMod]){
	if !(tehIcon = sprFallbackThumb)
		sprite_delete(tehIcon)
	tehIcon = sprite_add(modThumb[currentMod], 0, false, false, 0, 0)
}else
	tehIcon = sprFallbackThumb

if currentMod > -1
	draw_sprite(tehIcon, 0, x, y)
else
	draw_self()
	
draw_set_halign(fa_center)
draw_text(x+107, y+130, modName[currentMod]+"\nBy "+modAuthor[currentMod]+"\n"+modVersion[currentMod])