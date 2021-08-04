module yt_dl_checkbox_fn

import yt_dl_struct { App }

pub fn chk_audio_only_changed(mut app App, x bool) {
	app.form.audio_only = x
}
