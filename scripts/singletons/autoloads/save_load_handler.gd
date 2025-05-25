extends Node

const USER_FOLDER := "user://"
const SAVE_FOLDER := USER_FOLDER + "saves/"
const ROOT_FILE_NAME := "data"
var _extension = GameState.MAGIC.to_lower()



func santise_folder_name(island_name: String, creation_time: int) -> String:
	if island_name.is_empty():
		return "untitled_island"

	var sanitised_name := ""
	for c in island_name.to_lower():
		if (c >= 'a' and c <= 'z') or (c >= '0' and c <= '9'):
			sanitised_name += c
		else:
			sanitised_name += "_"
	
	sanitised_name = sanitised_name.replace("__", "_")

	while sanitised_name.ends_with("_"):
		sanitised_name = sanitised_name.substr(0, sanitised_name.length() - 1)
	while sanitised_name.begins_with("_"):
		sanitised_name = sanitised_name.substr(1)

	if sanitised_name.is_empty():
		sanitised_name = "untitled_island"
	
	return "%s_%d" % [sanitised_name, creation_time]




func save_game() -> bool:
	var folder_name: String = santise_folder_name(GameState.island_name, GameState.unix_created)
	var folder_path := SAVE_FOLDER + folder_name
	
	var dir := DirAccess.open(USER_FOLDER)
	if DirAccess.get_open_error() != OK:
		push_error("Could not open user folder: %s" % USER_FOLDER)
		return false
		
	if not dir.dir_exists(folder_path):
		if dir.make_dir_recursive(folder_path) != OK:
			push_error("Could not create save folder: %s" % folder_path)
			return false
	
	var filename: String = folder_path + "/" + ROOT_FILE_NAME + "." + _extension

	var file: FileAccess = FileAccess.open(filename, FileAccess.WRITE)

	GameState.save_game(file)
	file.close()

	
	file = FileAccess.open(filename, FileAccess.READ)
	
	GameState.load_game(file)
	
	file.close()
	
	print(GameState.save_version)
	print(GameState.money)
	print(GameState.island_name)
	print(GameState.islanders)
	
	return true

	
