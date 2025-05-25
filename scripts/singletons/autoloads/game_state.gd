extends Node

const MAX_ID: int = (2 ** 16) - 1


const MAGIC := "ISLESAV"
const MAGIC_LEN := len(MAGIC)


var save_version: int = 0
var unix_created: int = roundi(Time.get_unix_time_from_system())
var money: int = 0
var island_name: String
var islanders: Dictionary[int, IslanderData] = {}


func generate_islander_id() -> int:
	var out: int = -1
	while islanders.has(out) or out == -1:
		out = randi_range(0, MAX_ID)
	return out
		
func save_game(file: FileAccess):
	file.store_buffer(MAGIC.to_utf8_buffer())
	file.store_32(save_version)
	file.store_64(unix_created)
	file.store_64(money)
	file.store_pascal_string(island_name)
	file.store_16(islanders.size())
	


	for islander_id in islanders:
		var islander: IslanderData = islanders[islander_id]
		var islander_bytes: PackedByteArray = islander.serialise()
		file.store_16(islander_bytes.size())
		file.store_buffer(islander_bytes)
	
	

func load_game(file: FileAccess):
	if file.get_buffer(MAGIC_LEN).get_string_from_utf8() != MAGIC:
		push_error("Invalid save file magic")
		return
	save_version = file.get_32()
	unix_created = file.get_64()
	money = file.get_64()
	island_name = file.get_pascal_string()
	var islander_count: int = file.get_16()
	for i in range(islander_count):
		var islander_size: int = file.get_16()
		var islander_bytes: PackedByteArray = file.get_buffer(islander_size)
		var islander := IslanderData.deserialise(islander_bytes)
		islanders[islander.id] = islander
