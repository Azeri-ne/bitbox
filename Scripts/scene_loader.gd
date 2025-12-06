extends Node

func change_scene(path: String):
	get_tree().change_scene_to_file(path)
	
func _on_ExitButton_pressed():
	get_tree().quit()
