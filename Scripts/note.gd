extends Area2D

@export var speed := 500.0
var active := false
var lane: int = 1

signal note_done(note: Node2D)
@onready var anim := $hitPop
@onready var sprite := $noteSprite
@onready var trail := $Trail
var note_color: Color
var trail_color: Color

@export var fade_start_y: float = 200.0    # start fading
@export var fade_end_y: float = 550.0      # fully invisible
@export var flash_interval := 0.15
@export var is_speed_note := false
@export var speed_note_speed := 1000.0

var ghost: bool = false
var flash: bool = false
var flash_timer := 0.0
var flash_state := true



const NORMAL_COLORS = [
	Color.RED,
	Color.BLUE,
	Color.GREEN,
	Color.MAGENTA,
	Color.CYAN,
	Color.ORANGE
]

const FLASH_COLOR = Color(1.0, 1.0, 0.0) # yellow
const SPEED_COLOR = Color(0.0, 0.0, 0.0)



func activate(position: Vector2, is_ghost: bool = false, is_flash: bool = false, is_speed: bool = false):
	active = true
	global_position = position
	ghost = is_ghost
	flash = is_flash
	flash_timer = 0.0
	flash_state = true
	
	if flash:
		note_color = FLASH_COLOR
		trail_color = FLASH_COLOR
	elif is_speed:
		note_color = SPEED_COLOR
		trail_color = SPEED_COLOR
	else:
		note_color = NORMAL_COLORS[randi() % NORMAL_COLORS.size()]
		trail_color = note_color
	
	sprite.modulate = note_color
	sprite.modulate.a = 1.0
	trail.modulate = trail_color
	trail.modulate.a = 0.3
	
	visible = true
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
			trail.modulate.a = 1.0
		elif y > fade_end_y:
			sprite.modulate.a = 0.0
			trail.modulate.a = 0.0
		else:
			var t := (y - fade_start_y) / (fade_end_y - fade_start_y)
			sprite.modulate.a = 1.0 - clamp(t, 0.0, 1.0)
			trail.modulate.a = 1.0 - clamp(t, 0.0, 1.0)
	else:
		var y := global_position.y
	
		if y < fade_start_y:
			trail.modulate.a = 1.0
		elif y > fade_end_y:
			trail.modulate.a = 0.0
		else:
			var t := (y - fade_start_y) / (fade_end_y - fade_start_y)
			trail.modulate.a = 1.0 - clamp(t, 0.0, 1.0)
			
			
	if flash:
		flash_timer += delta
		if flash_timer >= flash_interval:
			flash_timer = 0.0
			flash_state = !flash_state
			visible = flash_state
	
	
	if is_speed_note:
		position.y += speed_note_speed * delta
	else:
		position.y += speed * delta
	
	# When off-screen, return to pool
	if position.y > 680: # Example screen height
		active = false
		emit_signal("note_done", self)
