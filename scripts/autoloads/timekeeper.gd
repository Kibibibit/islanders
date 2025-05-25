extends Timer


const UPDATE_DELTA: int = 5

var last_islander_event_time: Dictionary[String, int] = {}
var islanders: Dictionary[String, IslanderData] = {}

var loaded_data: bool = false

func _ready() -> void:
	autostart = false
	one_shot = false
	ignore_time_scale = true
	wait_time = float(UPDATE_DELTA)
	
	self.timeout.connect(_do_update)




func _get_unix_seconds() -> int:
	return floori(Time.get_unix_time_from_system()) 

func _do_update():
	if not loaded_data:
		push_error("Update loop started before data loaded!")
		return
	var current_time := _get_unix_seconds()
	for islander_id in islanders.keys():
		var islander: IslanderData = islanders[islander_id]
		islander.update_state(UPDATE_DELTA as float)
		
		var time_since_last_event = current_time - last_islander_event_time[islander_id]
		
		if time_since_last_event > 30:
			print("Islander is getting new event!")
			last_islander_event_time[islander_id] = current_time
