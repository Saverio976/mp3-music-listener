module yt_dl_checkbox_fn

import yt_dl_struct { App }

pub fn chk_video_changed(mut app App, x bool) {
	app.form.video = x
}
