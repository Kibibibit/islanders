extends Node



const COMPRESSION_MODE: FileAccess.CompressionMode = FileAccess.COMPRESSION_GZIP


func get_save_file_name(island_name: String) -> String:
	if len(island_name) < 1:
		island_name = "UNAMED"
	return "user://save_%s.sav" % island_name.to_lower().c_escape() 



func save_game() -> bool:
	var filename := get_save_file_name(GameState.island_name)
	var file := FileAccess.open(filename, FileAccess.WRITE)
	if FileAccess.get_open_error() != OK:
		if file.is_open():
			file.close()
		return false
	
	
	print("Trying to store data in %s" % filename)
	GameState.save(file)
	file.close()

	
	file = FileAccess.open(filename, FileAccess.READ)
	
	GameState.load(file)
	
	file.close()
	
	print(GameState.save_version)
	print(GameState.money)
	print(GameState.island_name)
	print(GameState.islanders)
	
	return true

	
