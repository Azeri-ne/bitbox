extends Control


@onready var clock: Label = $TopPanel/Clock


func _update_time():
	var datetime = Time.get_datetime_dict_from_system()
	
	var hour_12 = datetime.hour % 12
	if hour_12 == 0:
		hour_12 = 12
		
	var am_pm = "AM" if datetime.hour < 12 else "PM"
	
	clock.text = "%d:%02d:%02d %s" % [
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


func _process(delta: float) -> void:
	_update_time()
	
	var timer := Timer.new()
	_init_timer(timer)
