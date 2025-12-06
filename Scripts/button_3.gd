extends StaticBody2D

@onready var sprite3 = $button3Sprite
@onready var sprite3Shape = $CollisionShape2D
@onready var sprite3Rad = sprite3Shape.shape.radius 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
