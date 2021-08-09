module listiny_button_fn

import listiny_struct { App }
import os { execute }

pub fn btn_stop_audio(mut app App, x voidptr) {
	if app.sound.is_paused {
		return
	}
	if !app.sound.is_playing {
		return
	}
	i := app.sound.index
	
	execute('taskkill /im wmplayer.exe')

	app.sound.is_playing = false
	app.sound.is_paused = true
}
