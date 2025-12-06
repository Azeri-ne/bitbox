extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	SceneLoader.change_scene("res://Scenes/stage_select.tscn")
	


func _on_exit_button_pressed() -> void:
	get_tree().quit()
