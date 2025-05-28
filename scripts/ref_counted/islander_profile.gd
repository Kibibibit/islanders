extends RefCounted
class_name IslanderProfile


var islander_id: int

var first_name: String
var last_name: String
var nickname: String
var birthdate: String
var personality: Personality
var preferred_flavour: Flavour


func _init() -> void:
	first_name = ""
	last_name = ""
	nickname = ""
	birthdate = ""
	personality = Personality.new()
	preferred_flavour = Flavour.new()
