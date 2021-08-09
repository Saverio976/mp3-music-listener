module listiny_button_fn

import listiny_struct { App }
import os { execute }

pub fn btn_music_before(mut app App, x voidptr) {
	index_before := app.sound.index
	index_after := index_before - 1
	if index_after == -1 {
		app.sound.index = app.audio_files.len - 1
	} else {
		app.sound.index = index_after
	}

	execute('taskkill /im wmplayer.exe')
	
	app.sound.is_playing = false
	app.sound.is_paused = true

	btn_play_audio(mut app, voidptr(0))
}
