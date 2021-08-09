module listiny_button_fn

import listiny_struct { App }
import os { execute }

pub fn btn_play_audio(mut app App, x voidptr) {
	if app.sound.is_playing {
		return
	}
	i := app.sound.index
	
	go execute('wmplayer "${app.audio_files[i].path}"')

	app.sound.is_playing = true
	app.sound.is_paused = false
}
