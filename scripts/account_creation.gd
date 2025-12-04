extends Control

@onready var username_input: LineEdit = $UsernameInput
@onready var email_input: LineEdit = $EmailInput
@onready var password_input: LineEdit = $PasswordInput

@onready var status: Label = $Status

@onready var create_account_button: Button = $CreateAccount
@onready var back_button: Button = $GotoMain

func init_back_button():
	back_button.pressed.connect(func():
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	)
	
func init_account_creation_status():
	status.hide()

func create_account():
	var res = await Talo.player_auth.register(
		username_input.text,
		password_input.text,
	)
	
	if res == OK:
		status.text = "Success!"
		status.show()

	if res != OK:
		match Talo.player_auth.last_error.get_code():
			TaloAuthError.ErrorCode.IDENTIFIER_TAKEN:
				status.text = "Username is taken"
			
			_:
				status.text = Talo.player_auth.last_error.get_string()
		status.show()

func _ready() -> void:
	init_back_button()
	init_account_creation_status()
	
	create_account_button.pressed.connect(create_account)
