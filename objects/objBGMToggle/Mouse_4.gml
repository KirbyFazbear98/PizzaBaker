if audio_is_playing(musLoaderMus){
	audio_stop_sound(musLoaderMus)
	audio_play_sound(sndDisableBGM, 1, false)
}else{
	audio_play_sound(musLoaderMus, 1, true)
	audio_play_sound(sndEnableBGM, 1, false)
}