extends RefCounted
class_name Flavour




enum FlavourType {
	SWEET,
	BITTER,
	SOUR,
	SALTY,
	UMAMI,
	SPICY,
	NONE # Used for requests when villagers don't care about flavour
}

var sweetness: float
var bitterness: float
var sourness: float
var saltiness: float
var umami: float
var spiciness: float


func _init() -> void:
	sweetness = 0.0
	bitterness = 0.0
	sourness = 0.0
	saltiness = 0.0
	umami = 0.0
	spiciness = 0.0

func get_flavour_value(flavour_type: FlavourType) -> float:
	match flavour_type:
		FlavourType.SWEET:
			return sweetness
		FlavourType.BITTER:
			return bitterness
		FlavourType.SOUR:
			return sourness
		FlavourType.SALTY:
			return saltiness
		FlavourType.UMAMI:
			return umami
		FlavourType.SPICY:
			return spiciness
		_:
			# how did you get here?
			push_error("Invalid flavour type: " + str(flavour_type))
			return 0.0
