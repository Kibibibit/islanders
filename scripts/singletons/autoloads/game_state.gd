extends Node

const MAX_ID: int = 65535
const INVALID_ISLANDER_ID: int = -1

var money: int = 0
var island_name: String
var islanders: Dictionary[int, IslanderData] = {}

func generate_islander_id() -> int:
	var out: int = INVALID_ISLANDER_ID
	assert(len(islanders) < MAX_ID, "Cannot generate more islanders, maximum reached! How the hell did you make 65k villagers?")
	while islanders.has(out) or out == INVALID_ISLANDER_ID:
		out = randi_range(0, MAX_ID)
	return out

func get_islander(islander_id: int) -> IslanderData:
	if islanders.has(islander_id):
		return islanders[islander_id]
	else:
		push_error("Islander with ID %d not found!" % islander_id)
		return null