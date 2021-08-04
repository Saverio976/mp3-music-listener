module yt_dl_button_fn

import yt_dl_struct { App }

pub fn btn_music_before(mut app App, x voidptr) {
	index_before := app.sound.index
	index_after := index_before - 1
	if index_after == -1 {
		app.sound.index = app.audio_files.len - 1
	} else {
		app.sound.index = index_after
	}

	if !app.audio_files[index_before].is_in_device_buffer {
		btn_play_audio(mut app, voidptr(0))
		return
	}
	app.audio_files[index_before].sound.pause()
	app.audio_files[index_before].sound.seek(0)
	app.audio_files[index_before].sound.pause()
	app.sound.is_playing = false
	app.sound.is_paused = true

	btn_play_audio(mut app, voidptr(0))
}
