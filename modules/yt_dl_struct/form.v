module yt_dl_struct

pub struct Form {
pub mut:
	youtube_url string
	audio_index string
	audio_only  bool = true
	video       bool
	// TODO page_index int
}
