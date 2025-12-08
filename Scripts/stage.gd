extends Control

@onready var b1Rad = $AllButtons/Button1/CollisionShape2D.shape.radius
@onready var b2Rad = $AllButtons/Button2/CollisionShape2D.shape.radius
@onready var b3Rad = $AllButtons/Button3/CollisionShape2D.shape.radius
@onready var b4Rad = $AllButtons/Button4/CollisionShape2D.shape.radius
@onready var noteRad = $Note/CollisionShape2D.shape.radius
@onready var noteScenes = preload("res://Scenes/note.tscn")
@onready var note_pool = $NotePool

#@onready var noteShader = $ColorRect/GPUParticles2D
@export var BPM := 25
var beat_interval := 0.5 # spawn every 0.5s
var timer := 0.0
var Score = 0
var HP = 80
var miss_Count = 0
var good_Count = 0
var perf_Count = 0
var pause_menu


func _ready() -> void:
	beat_interval = (60.0 / BPM)
	note_pool = $NotePool
	$MusicPlayer.play()
	#NoteShader.emitting = true
	
	
var beat_count = 0
func _process(delta: float) -> void:
	$AllButtons._buttonInputs()

	if !$MusicPlayer.playing:
		return
	timer += delta
	if timer >= beat_interval:
		timer -= -beat_interval #-0.2
		beat_count += 1
		
		if beat_count % 18 == 0:
			var lane = randi_range(1,4)
			spawn_note(lane)
	noteTracker()


func _on_allButtons_button_1() -> void:
	#
	var button_pos = $AllButtons/Button1.global_position
	var first_note = note_pool.get_first_note_in_lane(1)
	
	if first_note:
		var note_pos = first_note.global_position
		var distance = Globals._getDistance(button_pos, note_pos)
		var overlap = Globals.getOverlap(b1Rad, noteRad, distance)
		Score = Globals.ScoreSystem(overlap, Score)
		
		_update_score_ui()
		
		
		if overlap != 0.0: #!= 0.0
			note_pool.return_to_pool(first_note)
			
		if overlap == 0.0:
			miss_Count += 1	
			HP -= 10
			Globals.hpSystem(HP)
			_update_missHit_ui()
			_update_hp_ui()
		elif overlap == 100.0:
			perf_Count += 1
			HP = min(HP + 5, 80)
			$Laser1/GPUParticles2D.restart()
			$AllButtons/HitSFX.play()
			_update_perfHit_ui()
			_update_hp_ui()
		else:
			good_Count += 1
			HP = min(HP + 3, 80)
			$Laser1/GPUParticles2D.restart()
			$AllButtons/Hit2SFX.play()
			_update_goodHit_ui()
			_update_hp_ui()
	else:
		print("No notes in lane 1")		

	
	
	
	
func _on_all_buttons_button_2() -> void:
	var button_pos = $AllButtons/Button2.global_position
	var first_note = note_pool.get_first_note_in_lane(2)
	if first_note:
		var note_pos = first_note.global_position
		var distance = Globals._getDistance(button_pos, note_pos)
		var overlap = Globals.getOverlap(b1Rad, noteRad, distance)
		Score = Globals.ScoreSystem(overlap, Score)
		_update_score_ui()
		if overlap != 0.0: #!= 0.0
			note_pool.return_to_pool(first_note)
			
		if overlap != 0.0: #!= 0.0
			note_pool.return_to_pool(first_note)
			
		if overlap == 0.0:
			miss_Count += 1	
			HP -= 10
			Globals.hpSystem(HP)
			_update_missHit_ui()
			_update_hp_ui()
		elif overlap == 100.0:
			perf_Count += 1
			HP = min(HP + 5, 80)
			$Laser2/GPUParticles2D.restart()
			_update_perfHit_ui()
			_update_hp_ui()
		else:
			good_Count += 1
			HP = min(HP + 3, 80)
			$Laser2/GPUParticles2D.restart()
			$AllButtons/Hit2SFX.play()
			_update_goodHit_ui()
			_update_hp_ui()
	else:
		print("No notes in lane 2")



func _on_all_buttons_button_3() -> void:
	var button_pos = $AllButtons/Button3.global_position
	var first_note = note_pool.get_first_note_in_lane(3)
	if first_note:
		var note_pos = first_note.global_position
		var distance = Globals._getDistance(button_pos, note_pos)
		var overlap = Globals.getOverlap(b1Rad, noteRad, distance)
		Score = Globals.ScoreSystem(overlap, Score)
		_update_score_ui()
		if overlap != 0.0: #!= 0.0
			note_pool.return_to_pool(first_note)
			
		if overlap == 0.0:
			miss_Count += 1	
			HP -= 10
			Globals.hpSystem(HP)
			_update_missHit_ui()
			_update_hp_ui()
		elif overlap == 100.0:
			perf_Count += 1
			HP = min(HP + 5, 80)
			$Laser3/GPUParticles2D.restart()
			_update_perfHit_ui()
			_update_hp_ui()
		else:
			good_Count += 1
			HP = min(HP + 3, 80)
			$Laser3/GPUParticles2D.restart()
			$AllButtons/Hit2SFX.play()
			_update_goodHit_ui()
			_update_hp_ui()
	else:
		print("No notes in lane 3")


func _on_all_buttons_button_4() -> void:
	var button_pos = $AllButtons/Button4.global_position
	var first_note = note_pool.get_first_note_in_lane(4)
	if first_note:
		var note_pos = first_note.global_position
		var distance = Globals._getDistance(button_pos, note_pos)
		var overlap = Globals.getOverlap(b1Rad, noteRad, distance)
		Score = Globals.ScoreSystem(overlap, Score)
		_update_score_ui()
		if overlap != 0.0:
			note_pool.return_to_pool(first_note)
			
			
		if overlap != 0.0: #!= 0.0
			note_pool.return_to_pool(first_note)
			
		if overlap == 0.0:
			miss_Count += 1	
			HP -= 10
			Globals.hpSystem(HP)
			_update_missHit_ui()
			_update_hp_ui()
		elif overlap == 100.0:
			perf_Count += 1
			HP = min(HP + 5, 80)
			$Laser4/GPUParticles2D.restart()
			$AllButtons/HitSFX.play()
			_update_perfHit_ui()
			_update_hp_ui()
		else:
			good_Count += 1
			HP = min(HP + 3, 80)
			$Laser4/GPUParticles2D.restart()
			$AllButtons/Hit2SFX.play()
			_update_goodHit_ui()
			_update_hp_ui()
	else:
		print("No notes in lane 4")






func spawn_note(lane):
	var note = note_pool.get_note()
	
	if note:
		#note.activate(Vector2(400, -100)) # start above screen
		var button = $AllButtons.get_child(lane - 1) if lane > 0 else $AllButtons.get_child(0)
		var spawn_pos = button.global_position + Vector2(0, -500)
		#note.activate(spawn_pos)
		#var is_ghost = randf() < 0.2
		#var is_flash = not is_ghost and randf() < 0.15
		#var is_speed := randf() < 0.10
		var is_ghost := randf() < 0.20
		var is_flash := false
		var is_speed := false
		if not is_ghost:
			if randf() < 0.15:
				is_flash = true
			elif randf() < 0.10:
				is_speed = true
		note.activate(spawn_pos, is_ghost, is_flash, is_speed)
		#note.activate(position)       # your existing activation
		#note_pool.activate_note_in_lane(note, lane)
		note_pool.activate_note_in_lane(note, lane)
		
		


func _on_music_player_finished() -> void:
	SceneLoader.change_scene("res://Scenes/results.tscn")

func _update_score_ui():
	#var Score: int = 0
	$ScoreLabel.text = "SCORE: %d" % Score

	
	 #$ScoreLabel.text = "SCORE: %d" % int(Score) #needs fixing nonexistent int contructor

func _update_missHit_ui():
	$missLabel.text = "MISS: %d" % miss_Count

func _update_goodHit_ui():
	$goodLabel.text = "GOOD: %d" % good_Count

func _update_perfHit_ui():
	$perfLabel.text = "PERFECT %d" % perf_Count
	
func _update_hp_ui():
	$hpLabel.text = "HP ❤️: %d" % HP

func noteTracker():
	var note
	var note_pos
	#var lane1pos
	
	#if lane1:  # if not null
		#lane1pos = lane1.global_position
	
	for lane in range(1, 5):
		note = note_pool.get_first_note_in_lane(lane)
		if note:
			#print("Lane", lane, "note pos:", note.global_position)
			note_pos = note.global_position.y
			#print(note_pos)
			if note_pos > 650:
				miss_Count += 1
				HP -= 3
				_update_missHit_ui()
				_update_hp_ui()
				Globals.hpSystem(HP)
