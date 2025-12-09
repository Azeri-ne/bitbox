extends Control

@onready var Music = preload("res://Assets/P3P - Title screen theme.mp3")

@onready var session_total_score: Label = $SessionTotalScore

func init_score():
	session_total_score.text = str(0)

func _ready():
	init_score()

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




func _on_stage_4_pressed() -> void:
	Transition.go_to("res://Scenes/stage_4.tscn")
	MusicPlayer.stop_music()


func _on_stage_5_pressed() -> void:
	Transition.go_to("res://Scenes/stage5.tscn")
	MusicPlayer.stop_music()



func _on_stage_6_pressed() -> void:
	Transition.go_to("res://Scenes/stage6.tscn")
	MusicPlayer.stop_music()



func _on_stage_7_pressed() -> void:
	Transition.go_to("res://Scenes/stage7.tscn")
	MusicPlayer.stop_music()


func _on_stage_8_pressed() -> void:
	Transition.go_to("res://Scenes/stage8.tscn")
	MusicPlayer.stop_music()


func _on_stage_9_pressed() -> void:
	Transition.go_to("res://Scenes/stage9.tscn")
	MusicPlayer.stop_music()


func _on_stage_10_pressed() -> void:
	Transition.go_to("res://Scenes/stage10.tscn")
	MusicPlayer.stop_music()
