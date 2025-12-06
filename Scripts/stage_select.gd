extends Control


func _on_stage_1_pressed() -> void:
	#SceneLoader.change_scene("res://Scenes/stage.tscn")
	Transition.go_to("res://Scenes/stage.tscn")
	MusicPlayer.stop_music()



func _on_back_button_pressed() -> void:
	#SceneLoader.change_scene("res://Scenes/MainScreen.tscn")
	Transition.go_to("res://Scenes/MainScreen.tscn")
	



func _on_stage_2_pressed() -> void:
	#SceneLoader.change_scene("res://Scenes/stage2.tscn")
	Transition.go_to("res://Scenes/stage2.tscn")
	MusicPlayer.stop_music()


func _on_stage_3_pressed() -> void:
	#SceneLoader.change_scene("res://Scenes/stage3.tscn")
	Transition.go_to("res://Scenes/stage3.tscn")
	MusicPlayer.stop_music()
