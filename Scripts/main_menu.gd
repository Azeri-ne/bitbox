extends Control

signal verification_required

@onready var _clock: Label = $TopPanel/Clock

@onready var _play_button: Button = $Buttons/Play
@onready var _gallery_button: Button = $Buttons/Gallery
@onready var _options_button: Button = $Buttons/Options
@onready var _exit_button: Button = $Buttons/Exit

@onready var _auth_panel_button: Button = $TopPanel/Authentication
@onready var _auth_panel: Control = $AuthWidget

@onready var _description_panel: Panel = $DescriptionPanel

@onready var status: Label = $AuthWidget/AuthPanel/Status
@onready var username: LineEdit = $AuthWidget/AuthPanel/UsernameInput
@onready var password: LineEdit = $AuthWidget/AuthPanel/PasswordInput
@onready var login: Button = $AuthWidget/AuthPanel/Login

@onready var _signup_button: Button = $AuthWidget/AuthPanel/Signup

func _update_time():
	var datetime = Time.get_datetime_dict_from_system()
	
	var hour_12 = datetime.hour % 12
	if hour_12 == 0:
		hour_12 = 12
		
	var am_pm = "AM" if datetime.hour < 12 else "PM"
	
	_clock.text = "%d:%02d:%02d %s" % [
		hour_12, 
		datetime.minute, 
		datetime.second, 
		am_pm
		]

func _init_timer(timer):
	timer.wait_time = 1.0
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_update_time)
	timer.start()

func _init_main_buttons():
	_exit_button.pressed.connect(get_tree().quit)
	
	_signup_button.pressed.connect(func():
		get_tree().change_scene_to_file("res://Scenes/account_creation.tscn")
	)

	_setup_button_description(_play_button, 
		"Play the rhythm game.")
	_setup_button_description(_gallery_button, 
		"View your art from the maps.")
	_setup_button_description(_options_button, 
		"Check and set your options.")
	_setup_button_description(_exit_button, 
		"Exit the game.")

	_play_button.pressed.connect(func():
		get_tree().change_scene_to_file("res://Scenes/stage_select.tscn")
	)

func _toggle_auth_panel_visibility():
	_auth_panel.visible = not _auth_panel.visible

func _init_auth_panel_button():
	_auth_panel.hide()
	status.hide()
	
	_auth_panel_button.pressed.connect(_toggle_auth_panel_visibility)

func _init_description_panel():
	_description_panel.hide()
	
func _setup_button_description(button: Button, text: String) -> void:
	button.mouse_entered.connect(Callable(self, "_on_button_hovered").bind(text))
	button.mouse_exited.connect(Callable(self, "_on_button_unhovered"))
	
func _on_button_hovered(description_text: String) -> void:
	var label = _description_panel.get_node("Description")
	label.text = description_text
	_description_panel.show()

func _on_button_unhovered() -> void:
	_description_panel.hide()

func login_player() -> void:
	var res := await Talo.player_auth.login(username.text, password.text)
	match res:
		Talo.player_auth.LoginResult.FAILED:
			match Talo.player_auth.last_error.get_code():
				TaloAuthError.ErrorCode.INVALID_CREDENTIALS:
					status.text = "Username or password is incorrect"
				_:
					status.text = Talo.player_auth.last_error.get_string()
			status.show()
			
		Talo.player_auth.LoginResult.VERIFICATION_REQUIRED:
			verification_required.emit()
		Talo.player_auth.LoginResult.OK:
			status.show()
			_auth_panel_button.text = username.text
			
			pass

func _process(_delta: float) -> void:
	_update_time()
	
func _ready() -> void:
	var timer := Timer.new()
	_init_timer(timer)
	
	_init_main_buttons()
	_init_auth_panel_button()
	_init_description_panel()
	
	login.pressed.connect(login_player)
	
	MusicPlayer.play_music(load("res://Assets/P3P - Title screen theme.mp3"))
