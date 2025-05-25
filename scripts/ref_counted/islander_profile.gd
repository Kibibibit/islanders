extends RefCounted
class_name IslanderProfile

# Breakdown:
# Name len * 3 - first, nick, lastnames
# Date size -> birthday
# 1 + 1 -> Body type enums
# ColorProfile.SIZE -> colors
# 1 + 1 -> width/height modifiers
# 1 + -> preferred flavour
# 1 -> life stage

const SIZE: int = SerialUtils.MAX_NAME_LEN*3 + \
				Date.SIZE + \
				Personality.SIZE + \
				1 + 1 + \
				ColorProfile.SIZE + \
				1 + 1 + \
				1 + \
				1
				
				

enum BodyType {
	A = 0, # Neutral proportios
	B = 1, # Slightly masculine
	C = 2, # Slightly feminine
	D = 3, # Very masculine
	E = 4, # Very feminine
}
enum YoungBodyType {
	A = 0, # Neutral proportions for teenagers
	B = 1, # Masculine for teenagers
	C = 2, # Feminine for teenagers
}

enum LifeStage {
	BABY = 0,
	CHILD = 1,
	TEENAGER = 2,
	YOUNG_ADULT = 3,
	ADULT = 4,
	ELDER = 5,
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
	preferred_flavour = Flavour.new()
	life_stage = LifeStage.ADULT

func _generate_adult_body_type(_young_body_type: YoungBodyType) -> BodyType:
	var distribution: Dictionary = BODY_TYPE_DISTRIBUTIONS[_young_body_type]

	var items: Array[BodyType] = []
	for b in distribution.keys():
		var count: int = distribution[b]
		for i in range(count):
			items.append(b)
	return items.pick_random()

func serialise() -> PackedByteArray:
	var ptr: int = 0
	var out := PackedByteArray()
	out.resize(SIZE)
	out.fill(0)
	
	SerialUtils.memcpy(first_name.to_utf8_buffer(), out, 0, ptr)
	ptr += SerialUtils.MAX_NAME_LEN
	
	SerialUtils.memcpy(last_name.to_utf8_buffer(), out, 0, ptr)
	ptr += SerialUtils.MAX_NAME_LEN
	
	SerialUtils.memcpy(nickname.to_utf8_buffer(), out, 0, ptr)
	ptr += SerialUtils.MAX_NAME_LEN
	
	out.encode_s64(ptr, birthdate.to_unix_time())
	ptr += Date.SIZE
	
	SerialUtils.memcpy(personality.serialise(), out, 0, ptr)
	ptr += Personality.SIZE

	out.encode_u8(ptr, body_type as int)
	ptr += 1
	out.encode_u8(ptr, young_body_type as int)
	ptr += 1

	SerialUtils.memcpy(colors.serialise(), out, 0, ptr)
	ptr += ColorProfile.SIZE

	out.encode_u8(ptr, SerialUtils.float_to_u8(height_modifier, 100))
	ptr += 1
	out.encode_u8(ptr, SerialUtils.float_to_u8(width_modifier, 100))
	ptr += 1
	SerialUtils.memcpy(preferred_flavour.serialise(), out, 0, ptr)
	ptr += Flavour.SIZE

	out.encode_u8(ptr, life_stage as int)
	
	
	return out

static func deserialise(data: PackedByteArray) -> IslanderProfile:
	var ptr: int = 0
	var out := IslanderProfile.new()
	
	out.first_name = data.slice(ptr, ptr + SerialUtils.MAX_NAME_LEN).get_string_from_utf8()
	ptr += SerialUtils.MAX_NAME_LEN
	
	
	out.last_name = data.slice(ptr, ptr + SerialUtils.MAX_NAME_LEN).get_string_from_utf8()
	ptr += SerialUtils.MAX_NAME_LEN
	
	
	out.nickname = data.slice(ptr, ptr + SerialUtils.MAX_NAME_LEN).get_string_from_utf8()
	ptr += SerialUtils.MAX_NAME_LEN
	
	out.birthdate = Date.from_unix_time(data.decode_s64(ptr))
	ptr += Date.SIZE
	
	out.personality = Personality.deserialise(data.slice(ptr, ptr + Personality.SIZE))
	ptr += Personality.SIZE

	out.body_type = data.decode_u8(ptr) as BodyType
	ptr += 1
	out.young_body_type = data.decode_u8(ptr) as YoungBodyType
	ptr += 1

	out.colors = ColorProfile.deserialise(data.slice(ptr, ptr + ColorProfile.SIZE))
	ptr += ColorProfile.SIZE

	out.height_modifier = SerialUtils.u8_to_float(data.decode_u8(ptr), 100)
	ptr += 1
	out.width_modifier = SerialUtils.u8_to_float(data.decode_u8(ptr), 100)
	ptr += 1

	out.preferred_flavour = Flavour.deserialise(data.slice(ptr, ptr + Flavour.SIZE))
	ptr += Flavour.SIZE

	out.life_stage = data.decode_u8(ptr) as LifeStage
	
	return out
