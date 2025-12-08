extends Node

@onready var player := $AudioStreamPlayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func play_music(stream: AudioStream):
	get_tree().paused = false
	player.stream = stream
	player.play()

func stop_music():
	player.stop()
