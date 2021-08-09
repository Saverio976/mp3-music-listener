module listiny_struct

import miniaudio { Device }

pub struct SoundState {
pub mut:
	index      int
	device     &Device
	is_playing bool
	is_paused  bool
}
