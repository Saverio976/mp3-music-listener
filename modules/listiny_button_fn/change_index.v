module listiny_button_fn

import listiny_struct { App }

pub fn btn_change_index(mut app App, x voidptr) {
	app.sound.index = app.form.audio_index.int()
	app.form.audio_index = ''
}
