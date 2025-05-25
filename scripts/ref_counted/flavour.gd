extends RefCounted
class_name Flavour


var sweetness: float
var bitterness: float
var sourness: float
var saltiness: float
var umami: float
var spiciness: float


func _init() -> void:
	sweetness = randf_range(-1.0, 1.0)
	bitterness = randf_range(-1.0, 1.0)
	sourness = randf_range(-1.0, 1.0)
	saltiness = randf_range(-1.0, 1.0)
	umami = randf_range(-1.0, 1.0)
	spiciness = randf_range(-1.0, 1.0)
