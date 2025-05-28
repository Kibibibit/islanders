extends Timer

## TODO: Replace language "event" with "request", events are more global things
## that happen island-wide. Requests are specific to an islander and their needs,
## however they do not need to directly be asking for something from the player.
## For example, fights, dreams and other things that the player can observe but
## do not interrupt the game flow.

const UPDATE_DELTA: int = 5


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
	for islander_id in GameState.islanders.keys():
		var islander: IslanderData = GameState.islanders[islander_id]
		islander.update_state(UPDATE_DELTA as float)
		
		var time_since_last_event = current_time - islander.state.last_event_time
		
		if time_since_last_event > 30:
			print("Islander is getting new event!")
			islander.state.last_event_time = current_time
