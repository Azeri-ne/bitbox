extends Control

signal resume_pressed
signal exit_pressed
#var stream = load("res://Assets/P3P - Title screen theme.mp3")

func _ready():
	visible = false
	#process_mode = Node.PROCESS_MODE_WHEN_PAUSED 	# IMPORTANT


func resume():
	get_tree().paused = false
	visible = false

func pause():
	get_tree().paused = true
	visible = true

func Esc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()
		


func _on_resume_pressed() -> void:
	resume()




func _on_exit_pressed() -> void:
	get_tree().paused = false
	Transition.go_to("res://Scenes/stage_select.tscn")
	#MusicPlayer.play_music(stream)
	print("Actual audio player:", MusicPlayer.player)
	print("MusicPlayer autoload:", MusicPlayer)
	
func _process(delta: float) -> void:
	Esc()
