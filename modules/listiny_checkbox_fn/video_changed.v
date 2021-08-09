module listiny_checkbox_fn

import listiny_struct { App }

pub fn chk_video_changed(mut app App, x bool) {
	app.form.video = x
}
