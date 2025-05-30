extends RefCounted
class_name IslanderProfile


var islander_id: int

var first_name: String
var last_name: String
var nickname: String
var birthdate: String
var personality: Personality
var preferred_flavour: Flavour
var home_location_id: int


func _init() -> void:
	first_name = ""
	last_name = ""
	nickname = ""
	birthdate = ""
	personality = Personality.new()
	preferred_flavour = Flavour.new()
	home_location_id = -1



## TODO: Implement this
func get_history() -> Array[IslanderHistoryEvent]:
	## Load from file, as this could get a little large
	return []

func add_history_event(_event: IslanderHistoryEvent) -> void:
	pass
