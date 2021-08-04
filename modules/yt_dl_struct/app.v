module yt_dl_struct

import ui { Grid }

pub struct App {
pub mut:
	form Form
	grid &Grid
	// TODO : page_text string
	audio_files  []AudioFile
	sound        SoundState
	audio_folder string
	video_folder string
}
