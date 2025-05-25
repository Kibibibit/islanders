extends RefCounted
class_name IslanderProfile


enum BodyType {
	A, # Neutral proportios
	B, # Slightly masculine
	C, # Slightly feminine
	D, # Very masculine
	E, # Very feminine
}
enum YoungBodyType {
	A, # Neutral proportions for teenagers
	B, # Masculine for teenagers
	C, # Feminine for teenagers
}

enum LifeStage {
	BABY,
	CHILD,
	TEENAGER,
	YOUNG_ADULT,
	ADULT,
	ELDER,
}

## How many times each body type appears in the distribution for young adults
const BODY_TYPE_DISTRIBUTIONS: Dictionary[YoungBodyType, Dictionary] = {
	YoungBodyType.A: { 
		BodyType.A: 5,
		BodyType.B: 3,
		BodyType.C: 3,
		BodyType.D: 2,
		BodyType.E: 2
	},
	YoungBodyType.B: {
		BodyType.A: 4,
		BodyType.B: 5,
		BodyType.C: 3,
		BodyType.D: 4,
		BodyType.E: 2
	},
	YoungBodyType.C: {
		BodyType.A: 4,
		BodyType.B: 3,
		BodyType.C: 5,
		BodyType.D: 2,
		BodyType.E: 5
	}
}

## Helper class to store color information
class ColorProfile:
	var favourite_color: Color
	var hair_color: Color
	var skin_color: Color
	var pupil_eye_color: Color
	var iris_eye_color: Color
	var lip_color: Color
	func _init() -> void:
		favourite_color = ColorPalettes.BASIC_PALETTE.pick_random()
		hair_color = ColorPalettes.HAIR_PRESET_PALETTE.pick_random()
		skin_color = ColorPalettes.SKIN_PRESET_PALETTE.pick_random()
		pupil_eye_color = Color.BLACK
		iris_eye_color = ColorPalettes.BASIC_PALETTE.pick_random()
		lip_color = Color(0.8, 0.2, 0.2) # Default to a soft red color
		




var first_name: String
var last_name: String
var nickname: String
var birthdate: Date
var personality: Personality
var body_type: BodyType
var young_body_type: YoungBodyType
var colors: ColorProfile
var height_modifier: float
var width_modifier: float
var preferred_flavour: Flavour
var life_stage: LifeStage


func _init() -> void:
	first_name = ""
	last_name = ""
	nickname = ""
	birthdate = Date.new()
	personality = Personality.new()
	body_type = BodyType.A
	young_body_type = YoungBodyType.A
	colors = ColorProfile.new()
	height_modifier = 1.0
	width_modifier = 1.0
	life_stage = LifeStage.ADULT



func _generate_adult_body_type(_young_body_type: YoungBodyType) -> BodyType:
	var distribution: Dictionary = BODY_TYPE_DISTRIBUTIONS[_young_body_type]

	var items: Array[BodyType] = []
	for b in distribution.keys():
		var count: int = distribution[b]
		for i in range(count):
			items.append(b)
	return items.pick_random()
