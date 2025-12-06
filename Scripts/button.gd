extends StaticBody2D

@onready var sprite1 = $button1Sprite
@onready var sprite1Shape = $CollisionShape2D
@onready var sprite1Rad = sprite1Shape.shape.radius 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
