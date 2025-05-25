extends Node

const MAX_ID: int = (2 ** 2) - 1


var save_version: int = 0
var money: int = 0
var island_name: String
var islanders: Dictionary[int, IslanderData] = {}


func generate_islander_id() -> int:
	var out: int = -1
	while islanders.has(out) or out == -1:
		out = randi_range(0, MAX_ID)
	return out
		
func save(file: FileAccess):
	file.store_32(save_version)
	file.store_64(money)
	file.store_pascal_string(island_name)
	
	var islander_save_dict: Dictionary[int, PackedByteArray] = {}
	
	for islander_id in islanders:
		var islander: IslanderData = islanders[islander_id]

		islander_save_dict[islander_id] = islander.serialise()
	
	file.store_var(islander_save_dict, true)
	

func load(file: FileAccess):
	save_version = file.get_32()
	money = file.get_64()
	island_name = file.get_pascal_string()
	var islander_data_dict: Dictionary[int, PackedByteArray] = file.get_var(true)
	islanders = {}
	for islander_id in islander_data_dict:
		islanders[islander_id] = IslanderData.deserialise(islander_data_dict[islander_id])
