extends Node

@export var note_scene: PackedScene
@export var pool_size := 50
var notes: Array = []


var active_notes := {
	1: [],
	2: [],
	3: [],
	4: []
}


func _ready():
	for i in range(pool_size):
		var note = note_scene.instantiate()
		note.visible = false
		add_child(note)
		notes.append(note)

		note.note_done.connect(_on_note_done)

func _on_note_done(note):
	return_to_pool(note)



func return_to_pool(note):
	#note.deactivate()
	if note and active_notes.has(note.lane):
		active_notes[note.lane].erase(note)
	note.deactivate()



func get_note() -> Area2D:
	for note in notes:
		if !note.active:
			return note
	return null



func activate_note_in_lane(note: Area2D, lane: int):
	#note.lane = lane
	#active_notes[lane].append(note)
	if not note:
		return
	note.lane = lane
	if not active_notes.has(lane):
		active_notes[lane] = []
	active_notes[lane].append(note)
	
	

	
func get_first_note_in_lane(lane: int) -> Area2D:
	if not active_notes.has(lane):
		return null
		
	var lane_notes = active_notes[lane]
	
	if lane_notes.is_empty():
		return null

	var first = lane_notes[0]
	for note in lane_notes:
		if not note:
			continue
		if note.global_position.y > first.global_position.y:
			first = note
	return first
