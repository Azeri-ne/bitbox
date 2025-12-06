extends Area2D

@export var speed := 400.0
var active := false
var lane: int = 1

signal note_done(note: Node2D)
@onready var anim := $hitPop
@onready var sprite := $noteSprite


@export var fade_start_y: float = 250.0    # start fading
@export var fade_end_y: float = 680.0      # fully invisible
var ghost: bool = false


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#position = Vector2(130, 89)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#position += Vector2(0, 1.0) * 350 * delta
	#if (position.length() >= 1000):
		#queue_free()
		#print("que is free")

func activate(position: Vector2, is_ghost: bool = false):
	active = true
	global_position = position
	ghost = is_ghost
	visible = true
	sprite.scale = Vector2(0.25, 0.25)
	sprite.modulate.a = 1.0
	set_deferred("monitoring", true)  # enable collision detection again

func deactivate():
	active = false
	visible = false
	set_deferred("monitoring", false) # disable collision so it doesn’t trigger events while inactive

func _process(delta):
	if !active:
		return
	position.y += speed * delta
	
	
#  GHOST FADE LOGIC (integrated)
	if ghost:
		var y := global_position.y
	
		if y < fade_start_y:
			sprite.modulate.a = 1.0
		elif y > fade_end_y:
			sprite.modulate.a = 0.0
		else:
			var t := (y - fade_start_y) / (fade_end_y - fade_start_y)
			sprite.modulate.a = 1.0 - clamp(t, 0.0, 1.0)
		
	
	# When off-screen, return to pool
	if position.y > 680: # Example screen height
		active = false
		emit_signal("note_done", self)

func play_hit_animation():
	active = false   
	anim.play("hitPop")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	pass


func _on_hit_pop_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hitPop":
		emit_signal("note_done", self)
