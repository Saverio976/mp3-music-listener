module listiny_button_fn

import listiny_struct { App }
import miniaudio

pub fn btn_play_audio(mut app App, x voidptr) {
	if app.sound.is_playing {
		return
	}
	if !app.sound.is_paused {
		app.sound.device = miniaudio.device()
	}
	i := app.sound.index
	if !app.audio_files[i].is_in_device_buffer {
		app.audio_files[i].init_miniaudio_sound()
		app.sound.device.add(i.str(), app.audio_files[i].sound)
	}
	app.audio_files[i].sound.play()
	app.sound.is_playing = true
	app.sound.is_paused = false
}
