extends Control



func _on_menu_pressed() -> void:
	Transition.go_to("res://Scenes/MainScreen.tscn")


func _on_next_pressed() -> void:
	Transition.go_to("res://Scenes/gallery2.tscn")

func _on_back_pressed() -> void:
	Transition.go_to("res://Scenes/gallery1.tscn")
