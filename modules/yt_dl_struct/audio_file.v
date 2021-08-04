module yt_dl_struct

import miniaudio

pub struct AudioFile {
pub:
	index int
	name  string
	path  string
pub mut:
	is_in_device_buffer bool
	sound               miniaudio.Sound
}

pub fn (af AudioFile) get_index_name() []string {
	return [af.index.str(), af.name]
}

pub fn (mut af AudioFile) init_miniaudio_sound() {
	af.sound = miniaudio.sound(af.path)
	af.is_in_device_buffer = true
}
