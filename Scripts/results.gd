extends Control





func _on_replay_button_pressed() -> void:
	#SceneLoader.change_scene("res://Scenes/stage_select.tscn")
	Transition.go_to("res://Scenes/stage_select.tscn")




func _on_exit_button_pressed() -> void:
	SceneLoader.change_scene("res://Scenes/MainScreen.tscn")
