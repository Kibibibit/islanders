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

## How much of an affect a flavour has on the similarity of two flavours.
const FLAVOUR_STRENGTHS: Dictionary[FlavourType, float] = {
	FlavourType.BITTER: 2.0,
	FlavourType.SOUR: 1.3,
	FlavourType.SALTY: 1.2,
	FlavourType.UMAMI: 0.9,
	FlavourType.SWEET: 0.7,
	FlavourType.SPICY: 1.8,
	FlavourType.NONE: 0.0
}
## Sum for normalising
const FLAVOUR_STRENGTH_SUM: float = 2.0 + 1.8 + 1.3 + 1.2 + 0.9 + 0.7


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

func get_strongest_flavour() -> FlavourType:
	var max_value: float = -1.0
	var strongest_flavour: FlavourType = FlavourType.NONE
	
	for flavour in FlavourType.values():
		var value: float = get_flavour_value(flavour)
		if value > max_value:
			max_value = value
			strongest_flavour = flavour
	
	return strongest_flavour

## TODO: Possibly account for preferred flavours of the islander?
## Spicy flavours tend to be a bit more polarising whereas most people like sweet.
## However this could just be reflected in the way preferred flavours are generated
func similarity(other_flavour: Flavour) -> float:
	var similarity_score: float = 0.0
	
	for flavour in FlavourType.values():
		var this_value: float = get_flavour_value(flavour)
		var other_value: float = other_flavour.get_flavour_value(flavour)
		
		similarity_score += abs(other_value-this_value) * FLAVOUR_STRENGTHS[flavour]
	
	return 1.0 - (similarity_score / FLAVOUR_STRENGTH_SUM)

static func get_flavour_name(flavour_type: FlavourType) -> String:
	match flavour_type:
		FlavourType.SWEET:
			return "Sweet"
		FlavourType.BITTER:
			return "Bitter"
		FlavourType.SOUR:
			return "Sour"
		FlavourType.SALTY:
			return "Salty"
		FlavourType.UMAMI:
			return "Umami"
		FlavourType.SPICY:
			return "Spicy"
		_:
			push_error("Invalid flavour type: " + str(flavour_type))
			return "Unknown Flavour"