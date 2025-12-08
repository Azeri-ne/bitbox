extends Control





func _on_replay_button_pressed() -> void:
	#SceneLoader.change_scene("res://Scenes/stage_select.tscn")
	Transition.go_to("res://Scenes/stage_select.tscn")
	#MusicPlayer.play_music(load("res://Assets/P3P - Title screen theme.mp3"))



func _on_exit_button_pressed() -> void:
	SceneLoader.change_scene("res://Scenes/MainScreen.tscn")
	#MusicPlayer.play_music(load("res://Assets/P3P - Title screen theme.mp3"))
