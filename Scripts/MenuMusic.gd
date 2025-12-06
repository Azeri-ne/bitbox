extends Node

@onready var player := $AudioStreamPlayer

func play_music(stream: AudioStream):
	if player.stream != stream:
		player.stream = stream
		player.play()

func stop_music():
	player.stop()
