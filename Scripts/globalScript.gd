extends Node

@export var pressSFX := preload("res://Assets/button-click-289742.mp3")
@export var glow: Sprite2D
@onready var audioPlay := AudioStreamPlayer2D.new()


var tween: Tween = null

var Percent
var Score: int = 0
var HP: int = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if pressSFX != null:
		add_child(audioPlay)
		audioPlay.stream = pressSFX
		
		
	if glow != null:
		glow.visible = false
		glow.modulate.a = 0.0
		tween = create_tween()
		tween.pause()



#func _process(delta: float) -> void:
	#pass
	

func _getDistance(pos1: Vector2, pos2: Vector2):
	var Distance = pos1.distance_to(pos2)
	return Distance

	
func getOverlap(r1: float, r2: float, d: float) -> float: 
	#No overlap
	if d >= r1 + r2:
		print("No overlap", " MISS!")

		return 0.0
		
	
	#for full and partial overlap
	#change in line 30 elif to 10.0 if partial overlap in line 41 is part1 + part2 + 3 for easier accuracy
	
	#One circle inside another
	elif d <= abs(r1 - r2) + 1.5: #can either be 1.0 or 1.5. Changing hitboxes may be better for improving accuracy
		print("Full overlap", " PERFECT!")
		var smallerArea = PI * min(r1, r2) ** 2
		var baseArea = PI * r1 ** 2

		return (smallerArea / baseArea) * 100.0
		
	#Partial overlap
	var part1 = r1**2 * acos((d**2 + r1**2 - r2**2) / (2 * d * r1))
	var part2 = r2**2 * acos((d**2 + r2**2 - r1**2) / (2 * d * r2))
	var part3 = 0.5 * sqrt((-d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (d + r1 + r2))
	print("Partial overlap", " GOOD!")
	var overlapArea = part1 + part2 - part3
	var baseArea = PI * r1 ** 2
	Percent = (overlapArea / baseArea) * 100.0

	return (overlapArea / baseArea) * 100.0
	
	
func ScoreSystem(Percent: float, Score: int) -> int:
	if Percent == 0.0:
		return Score - 3
	elif Percent <= 25.0:
		return Score + 2
	elif Percent <= 50.0:
		return Score + 5
	elif Percent <= 75.0:
		return Score + 8
	elif Percent == 100:
		return Score + 10
	else:
		return Score + 0
		
func hpSystem(HP: int):
	if HP <= 0:
		Transition.go_to("res://Scenes/results.tscn")
		return HP

func btnEffect():
	if glow != null:
		glow.visible = true
		tween.kill()  # remove previous tween if any
		tween = create_tween()
		tween.set_loops()  # loop indefinitely
		tween.tween_property(glow, "modulate:a", 0.6, 0.2)
		tween.tween_property(glow, "modulate:a", 0.3, 0.2)
		
	
	if pressSFX != null:
		audioPlay.play()
func releaseBtn():
	if glow != null:
		glow.visible = false

		
func play_sfx():
	if audioPlay.stream != null:
		audioPlay.play()
		
