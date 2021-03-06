module listiny_button_fn

import listiny_struct { App }

pub fn btn_stop_audio(mut app App, x voidptr) {
	if app.sound.is_paused {
		return
	}
	if !app.sound.is_playing {
		return
	}
	i := app.sound.index
	app.audio_files[i].sound.pause()
	app.audio_files[i].sound.seek(0)
	app.audio_files[i].sound.pause()
	app.sound.is_playing = false
	app.sound.is_paused = true
}
