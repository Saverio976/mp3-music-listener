module listiny_button_fn

import os
import youtube_dl { download_audio, download_video }
import listiny_struct { App, AudioFile }

pub fn btn_download_yt(mut app App, x voidptr) {
	mut url := ''
	if !app.form.youtube_url.starts_with('https://') {
		url = 'https://youtu.be/' + app.form.youtube_url
	} else {
		url = app.form.youtube_url
	}
	app.form.youtube_url = ''

	if app.form.audio_only {
		go download_audio_go(mut app, url)
	}
	if app.form.video {
		go download_video_go(mut app, url)
	}
}

fn download_audio_go(mut app App, url string) {
	path := download_audio(url, app.audio_folder) or { return }
	$if windows {
		audio_file := AudioFile{
			index: app.audio_files.len
			name: os.file_name(path).trim_right('.mp3')
			path: path
		}
		app.audio_files << audio_file
		app.grid.body << audio_file.get_index_name()
	} $else {
		audio_file := AudioFile{
			index: app.audio_files.len
			name: os.file_name(path).trim_right('.mp3')
			path: path
			is_in_device_buffer: false
		}
		app.audio_files << audio_file
		app.grid.body << audio_file.get_index_name()
	}
}

fn download_video_go(mut app App, url string) {
	_ := download_video(url, app.video_folder) or { return }
}
