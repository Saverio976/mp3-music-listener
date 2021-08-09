module listiny_struct

pub struct AudioFile {
pub:
	index int
	name  string
	path  string
}

pub fn (af AudioFile) get_index_name() []string {
	return [af.index.str(), af.name]
}