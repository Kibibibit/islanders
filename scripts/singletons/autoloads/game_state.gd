extends Node

const MAX_ID: int = (2 ** 16) - 1


var money: int = 0
var island_name: String
var islanders: Dictionary[int, IslanderData] = {}

func generate_islander_id() -> int:
	var out: int = -1
	while islanders.has(out) or out == -1:
		out = randi_range(0, MAX_ID)
	return out

func get_islander(islander_id: int) -> IslanderData:
	if islanders.has(islander_id):
		return islanders[islander_id]
	else:
		push_error("Islander with ID %d not found!" % islander_id)
		return null