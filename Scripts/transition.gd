extends CanvasLayer

var next_scene := ""


func _ready():
	$AnimationPlayer.play("fade_in")



func go_to(scene_path: String):
	next_scene = scene_path
	$AnimationPlayer.play("fade_out")



func _on_animation_player_animation_finished(anim: StringName) -> void:
	if anim == "fade_out":
		# Change scene
		get_tree().change_scene_to_file(next_scene)
		# Fade in after loading
		$AnimationPlayer.play("fade_in")
