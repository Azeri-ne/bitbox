extends Node2D



@onready var texUnpress = preload("res://Assets/button_unpressed.png")
@onready var texPress = preload("res://Assets/button_pressed.png")

@onready var button1 = $Button1
@onready var b1Sprite = $Button1/button1Sprite
@onready var b1Shape = $Button1/CollisionShape2D
@onready var b1Rad = b1Shape.shape.radius

@onready var button2 = $Button2
@onready var b2Sprite = $Button2/button2Sprite
@onready var b2Shape = $Button2/CollisionShape2D
@onready var b2Rad = b2Shape.shape.radius

@onready var button3 = $Button3
@onready var b3Sprite = $Button3/button3Sprite
@onready var b3Shape = $Button3/CollisionShape2D
@onready var b3Rad = b3Shape.shape.radius

@onready var button4 = $Button4
@onready var b4Sprite = $Button4/button4Sprite
@onready var b4Shape = $Button4/CollisionShape2D
@onready var b4Rad = b4Shape.shape.radius



signal Button1
signal Button2
signal Button3
signal Button4
signal AllButton

func _ready() -> void:
	pass 



func _buttonInputs():
	if (Input.is_action_just_pressed("1_Note")):
		b1Sprite.texture = texPress
		Globals.btnEffect()
		Globals.play_sfx()
		flash_button(b1Sprite)
		Button1.emit()
		#return b1Shape.global_position
	if (Input.is_action_just_released("1_Note")):
		b1Sprite.texture = texUnpress
		
	if (Input.is_action_just_pressed("2_Note")):
		b2Sprite.texture = texPress
		Globals.btnEffect()
		Globals.play_sfx()
		flash_button(b2Sprite)
		Button2.emit()
	if (Input.is_action_just_released("2_Note")):
		b2Sprite.texture = texUnpress
		
	if (Input.is_action_just_pressed("3_Note")):
		b3Sprite.texture = texPress
		Globals.btnEffect()
		Globals.play_sfx()
		flash_button(b3Sprite)
		Button3.emit()
	if (Input.is_action_just_released("3_Note")):
		b3Sprite.texture = texUnpress
		
	if (Input.is_action_just_pressed("4_Note")):
		b4Sprite.texture = texPress
		Globals.btnEffect()
		Globals.play_sfx()
		flash_button(b4Sprite)
		Button4.emit()
	if (Input.is_action_just_released("4_Note")):
		b4Sprite.texture = texUnpress
		
	if (Input.is_action_just_pressed("All_Note")):
		print("All buttons")
	

#func _input(event: InputEvent) -> void:
	#pass

func _process(delta: float) -> void:
	#_buttonInputs()
	pass
	
func flash_button(sprite: Sprite2D):
	# make a Tween that modifies the alpha quickly
	var tween = create_tween()
	sprite.modulate = Color(1,1,1,1) # normal
	tween.tween_property(sprite, "modulate:a", 0.5, 0.1) # fade out alpha to 0.5
	tween.tween_property(sprite, "modulate:a", 1.0, 0.1) # fade back in
