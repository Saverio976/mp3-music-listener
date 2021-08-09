module listiny_checkbox_fn

import listiny_struct { App }

pub fn chk_audio_only_changed(mut app App, x bool) {
	app.form.audio_only = x
}
