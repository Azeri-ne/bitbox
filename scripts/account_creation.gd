extends Control

@onready var username_input: TextEdit = $UsernameInput
@onready var email_input: TextEdit = $EmailInput
@onready var password_input: TextEdit = $PasswordInput

@onready var account_creation_status: Label = $Status

@onready var create_account_button: Button = $CreateAccount
@onready var back_button: Button = $GotoMain

func init_back_button():
	back_button.pressed.connect(func():
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	)
	
func init_account_creation_status():
	account_creation_status.hide()

func _ready() -> void:
	init_back_button()
