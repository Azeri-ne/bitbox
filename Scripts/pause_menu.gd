extends Control

signal resume_pressed
signal exit_pressed

func _ready():
	visible = false
	#process_mode = Node.PROCESS_MODE_WHEN_PAUSED 	# IMPORTANT
	


#func _unhandled_input(event: InputEvent) -> void:
	#if not visible:
		#return
	#if event.is_action_pressed("ui_cancel"):
		#hide_menu()

#func show_menu():
	#visible = true
	#get_tree().paused = true
#
#func hide_menu():
	#visible = false
	#get_tree().paused = false



func resume():
	get_tree().paused = false
	visible = false

func pause():
	get_tree().paused = true
	visible = true

func Esc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()
		


func _on_resume_pressed() -> void:
	#hide_menu()
	#emit_signal("resume_pressed")
	#hide_menu()
	resume()

#func unpause() -> void:
	#if (Input.is_action_pressed("PauseUnpause")):
		#visible = true
		#get_tree().paused = true


func _on_exit_pressed() -> void:
	#emit_signal("exit_pressed")
	#visible = true
	#hide_menu()
	get_tree().paused = false
	Transition.go_to("res://Scenes/stage_select.tscn")
	
func _process(delta: float) -> void:
	Esc()
