module listiny_button_fn

import listiny_struct { App }
import os { execute }
import time

pub fn btn_music_after(mut app App, x voidptr) {
	index_before := app.sound.index
	index_after := index_before + 1
	if index_after == app.audio_files.len {
		app.sound.index = 0
	} else {
		app.sound.index = index_after
	}
	
	_ := execute('taskkill /im wmplayer.exe')

	app.sound.is_playing = false
	app.sound.is_paused = true
	time.sleep(1 * time.second)
	btn_play_audio(mut app, voidptr(0))
}
