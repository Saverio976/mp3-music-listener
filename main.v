module main

import ui
import os
import gx
import listiny_struct { App, AudioFile }
import listiny_checkbox_fn { 
	chk_audio_only_changed,
	chk_video_changed
}
import listiny_button_fn { 
	btn_change_index, 
	btn_download_yt, 
	btn_music_after, 
	btn_music_before, 
	btn_pause_audio, 
	btn_play_audio,
	// TODO : btn_page_back,
	// TODO : btn_page_next
}

const (
	win_width = 800
	win_height = 600
	grid_header = ['Index', 'Name']
	grid_cell_height = 20
	audio_folder = os.resource_abs_path(os.join_path('.', 'assets', 'audio'))
	video_folder = os.resource_abs_path(os.join_path('.', 'assets', 'video'))
	default_font = os.resource_abs_path(os.join_path('.', 'assets', 'fonts', 'NotoSerif-Italic.ttf'))
)

fn find_local_audio_file() []AudioFile {
	mut audio_files := []AudioFile{}
	for i, file in os.walk_ext(audio_folder, '.mp3') {
		$if windows {
			audio_files << AudioFile{
				index: i
				name: os.file_name(file).trim_right('.mp3')
				path: file
			}
		} $else {
			audio_files << AudioFile{
				index: i
				name: os.file_name(file).trim_right('.mp3')
				path: file
				is_in_device_buffer: false
			}
		}
	}
	return audio_files
}

fn get_matrix_index_name(audio_files []AudioFile) [][]string {
	mut grid_body := [][]string{}
	for af in audio_files {
		grid_body << af.get_index_name()
	}
	return grid_body
}

fn music_grid_init(audio_files []AudioFile) &ui.Grid {
	mut gr := ui.grid(ui.GridConfig{
			header: grid_header
			body: get_matrix_index_name(audio_files)
			width: win_width - 20
			height: (win_height*7 / 8) - (win_height/4 + 30)
			cell_height: grid_cell_height
	})
	gr.x = 10
	gr.y = win_height/4 + 20
	gr.cell_width = (win_width - 20) / 2
	return gr
}

[console]
fn main() {
	audio_files := find_local_audio_file()
	mut app := &App{
		grid: music_grid_init(audio_files)
		audio_files: audio_files
		audio_folder: audio_folder
		video_folder: video_folder
	}
	window := ui.window(ui.WindowConfig{
		width: win_width
		height: win_height
		state: app
		title: 'youtube-downloader'
		font_path: default_font
		bg_color: gx.dark_blue
		children: [
			ui.rectangle(
				ui.RectangleConfig{
					x: 0
					y: 0
					height: 25
					width: win_width
					color: gx.black
				}
			),
			ui.group(
				ui.GroupConfig{
					x: 10
					y: 30
					title: 'download'
					children: [
						ui.textbox(
							width: win_width - 20
							max_len: 100
							placeholder: 'Enter video url or video id'
							text: &app.form.youtube_url
							is_focused: true
						),
						ui.checkbox(ui.CheckBoxConfig{
							text: 'Download Audio'
							checked: true
							on_check_changed: chk_audio_only_changed
						}),
						ui.checkbox(ui.CheckBoxConfig{
							text: 'Download Video'
							checked: false
							on_check_changed: chk_video_changed
						}),
						ui.button(
							width: -5
							text: 'Apply Download'
							onclick: btn_download_yt
						)
					]
				}
			),
			ui.rectangle(ui.RectangleConfig{
				x: 0
				y: win_height/4 + 5
				height: 10
				width: win_width
				color: gx.black
			}),
			*app.grid,
			/* TODO ui.row(
				{
					spacing: 1
					margin: {
						top: win_height*7 / 8
						bottom: win_height*7 / 8 + 10
						left: 10
						right: 10
					}
				},
				[
					ui.column(
						{},
						[
							ui.button(
								text: 'Page Back'
								onclick: btn_page_back
							)
						]
					),
					ui.column(
						{},
						[
							ui.textbox({
								text: &app.page_text
								read_only: true
							})
						]
					)
					ui.column(
						{},
						[
							ui.button(
								text: 'Page Next'
								onclick: btn_page_next
							)
						]
					)
				]
			)*/
			ui.row(
				ui.RowConfig{
					spacing: 1
					margin: ui.Margin{
						top: win_height*15 / 16
						bottom: win_height
						left: 10
						right: 10
					}
					children: [
						ui.column(
							ui.ColumnConfig{
								children: [
									ui.button(
										text: '<<'
										onclick: btn_music_before
										height: 25
									)
								]
							}
						),
						ui.column(
							ui.ColumnConfig{
								children: [
									ui.button(
										text: 'Play'
										onclick: btn_play_audio
										height: 25
									)
								]
							}
						),
						ui.column(
							ui.ColumnConfig{
								children: [
									ui.button(
										text: 'Pause'
										onclick: btn_pause_audio
										height: 25
									)
								]
							}
						),
						ui.column(
							ui.ColumnConfig{
								children: [
									ui.button(
										text: '>>'
										onclick: btn_music_after
										height: 25
									)
								]
							}
						)
					]
				}
			)	
		]
	})
	ui.run(window)
	$if windows {
		if app.sound.is_playing {
			os.execute('taskkill /im wmplayer.exe')
		}
	} $else {
		if app.sound.is_paused && app.sound.is_playing {
			app.sound.device.free()
		}
	}
}
