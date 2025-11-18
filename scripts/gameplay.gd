class_name Gameplay
extends Control

const _NOTE := preload("res://scripts/note.gd")
const _LANE := preload("res://scripts/lane.gd")
# const _HIT_LIGHTING := preload()

const _LANE_WIDTH := 100
const _HIT_RECEPTOR_Y_OFFSET := 40
const _MS_LOAD_THRESHOLD := 2000

@export var map:Map

var _audio_offset: int
var _scroll_speed_factor: float
var _num_lanes: int
var _lane_action_names: PackedStringArray = []
var _physics_process_current_song_time: float
# var _process_current_song_time: float
var _lanes: Array[Lane] = []
var _judgements: Array[Dictionary] = [
	{"time" = 18, "text" = ""},
	{"time" = 43, "text" = "Perfect"},
	{"time" = 76, "text" = "Great"},
	{"time" = 106, "text" = "Good"},
	{"time" = 127, "text" = "Bad"},
	{"time" = 164, "text" = "Miss"},
]
var _last_judgement_threshold: int
var _judgement_tween: Tween
var _hit_combo := 0:
	set(new_combo):
		_hit_combo = new_combo
		_combo_label.text = (
				""
				if new_combo == 0
				else str(new_combo)
		)
var _hit_error_size: Vector2
var _hit_error_x_offset: float
var _is_hit_lighting_enabled := true
var _is_hit_particles_enabled := true
var _is_early_miss_window_disabled := true

@onready var _audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var _level_end_timer: Timer = %LevelEndTimer
@onready var _pause_menu: PauseMenu = %PauseMenu
@onready var _combo_label: Label = %ComboLabel
@onready var _judgement_label: Label = %JudgementLabel
# @onready var _hit_error_bar: ColorRect = %HitErrorBar
@onready var _playfield: Control = %Playfield


func _ready() -> void:
	_judgement_label.text = ""
	_combo_label.text = ""
	_pause_menu.map_to_retry = map
	_last_judgement_threshold = _judgements[-1]["time"]
	var gameplay_settings := ConfigHandler.load_settings("gameplay")
	_audio_offset = gameplay_settings.audio_offset
	_audio_offset += int(AudioServer.get_output_latency())
	_scroll_speed_factor = gameplay_settings.scroll_speed / 30.0
	var _number_of_lanes: int = 4
	_lanes_h_box_container.custom_minimum_size.x = _num_lanes * _LANE_WIDTH
	_spacer.custom_minimum_size.y = _HIT_RECEPTOR_Y_OFFSET
	_hit_error_size = _hit_error_bar.size
	_hit_error_size.x /= 2.0
	_hit_error_x_offset = _hit_error_bar.size.x / 4.0

	for lane_idx in range(_number_of_lanes):
		var lane := _LANE.instantiate() as Lane
		_lanes_h_box_container.add_child(lane)
		_lanes.append(lane)
		if lane.hit_lighting.texture is not GradientTexture2D:
			continue
		
		var hit_lighting_texture := lane.hit_lighting.texture as GradientTexture2D
		# Don't know why this doesn't work when _LANE_WIDTH < 60.
		# Works in all other cases.
		hit_lighting_texture.width = _LANE_WIDTH
