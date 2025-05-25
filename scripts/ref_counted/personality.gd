extends RefCounted
class_name Personality

const SIZE: int = 11

## Affects the overall rate at which a person changes energy
var energetic: float
## Affects energy level spending time alone
var introverted: float
## Affects energy level spending time with others
var extroverted: float

## Affects energy level spending time outdoors
var outdoors_preference: float
## Affects energy level spending time indoors
var indoors_preference: float
## Affects preference for competitive activities
var competitiveness: float

## How positive or negative the person is.
## Will affect how they react to events
## and how well they get along with others.
var outlook: float
## Controls how randomly the person acts
var spontaneity: float

## Affects energy level for physical activities
var athleticism: float
## Affects energy level for creative activities
var creativity: float
## Affects energy level for mental activities
var curiosity: float


func _init() -> void:
	introverted = 0.5
	extroverted = 0.5

	outdoors_preference = 0.5
	indoors_preference = 0.5
	competitiveness = 0.5

	outlook = 0.5
	spontaneity = 0.5

	athleticism = 0.5
	creativity = 0.5
	curiosity = 0.5

func serialise() -> PackedByteArray:
	var out := PackedByteArray()
	out.resize(SIZE)
	out.fill(0)
	out.encode_s8(0, SerialUtils.float_to_s8(energetic))
	out.encode_s8(1, SerialUtils.float_to_s8(introverted))
	out.encode_s8(2, SerialUtils.float_to_s8(extroverted))
	out.encode_s8(3, SerialUtils.float_to_s8(outdoors_preference))
	out.encode_s8(4, SerialUtils.float_to_s8(indoors_preference))
	out.encode_s8(5, SerialUtils.float_to_s8(competitiveness))
	out.encode_s8(6, SerialUtils.float_to_s8(outlook))
	out.encode_s8(7, SerialUtils.float_to_s8(spontaneity))
	out.encode_s8(8, SerialUtils.float_to_s8(athleticism))
	out.encode_s8(9, SerialUtils.float_to_s8(creativity))
	out.encode_s8(10, SerialUtils.float_to_s8(curiosity))
	return out

static func deserialise(data: PackedByteArray) -> Personality:
	var personality = Personality.new()
	personality.energetic = SerialUtils.s8_to_float(data.decode_s8(0))
	personality.introverted = SerialUtils.s8_to_float(data.decode_s8(1))
	personality.extroverted = SerialUtils.s8_to_float(data.decode_s8(2))
	personality.outdoors_preference = SerialUtils.s8_to_float(data.decode_s8(3))
	personality.indoors_preference = SerialUtils.s8_to_float(data.decode_s8(4))
	personality.competitiveness = SerialUtils.s8_to_float(data.decode_s8(5))
	personality.outlook = SerialUtils.s8_to_float(data.decode_s8(6))
	personality.spontaneity = SerialUtils.s8_to_float(data.decode_s8(7))
	personality.athleticism = SerialUtils.s8_to_float(data.decode_s8(8))
	personality.creativity = SerialUtils.s8_to_float(data.decode_s8(9))
	personality.curiosity = SerialUtils.s8_to_float(data.decode_s8(10))
	return personality
