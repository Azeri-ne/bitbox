extends StaticBody2D

@onready var sprite2 = $button2Sprite
@onready var sprite2Shape = $CollisionShape2D
@onready var sprite2Rad = sprite2Shape.shape.radius 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
