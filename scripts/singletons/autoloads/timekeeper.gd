extends Timer

const UPDATE_DELTA: int = 5

const MAX_TIME_BETWEEN_REQUESTS: float = 240.0 # 4 minutes
const MIN_TIME_BETWEEN_REQUESTS: float = 25.0


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
	print("Doing an update loop")
	if not loaded_data:
		push_error("Update loop started before data loaded!")
		return
	var current_time := _get_unix_seconds()
	for islander_id in GameState.islanders.keys():
		var islander: IslanderData = GameState.islanders[islander_id]
		islander.update_state(UPDATE_DELTA as float)
		
		var time_since_last_request: float = current_time - islander.state.last_request_time
		
		if time_since_last_request < MIN_TIME_BETWEEN_REQUESTS:
			continue # Not enough time has passed since last request
		
		if time_since_last_request > MAX_TIME_BETWEEN_REQUESTS:
			islander.state.generate_request()
		else:
			var probability: float = smoothstep(MIN_TIME_BETWEEN_REQUESTS, MAX_TIME_BETWEEN_REQUESTS, time_since_last_request)
			if randf() < probability:
				islander.state.generate_request()
	print("\n\n\n\n\n")
	for islander_id in GameState.islanders.keys():
		
		print("Islander %d: Energy: %.5f, Hunger: %.5f, Happiness: %.2f, Level: %d, Request Queue Size: %d" % [
			islander_id,
			GameState.get_islander(islander_id).state.energy,
			GameState.get_islander(islander_id).state.hunger,
			GameState.get_islander(islander_id).state.happiness,
			GameState.get_islander(islander_id).state.level,
			GameState.get_islander(islander_id).state.request_queue.size()
		])

	
