extends RefCounted
class_name Flavour

const SIZE: int = 6

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


func serialise() -> PackedByteArray:
	var out := PackedByteArray()
	out.resize(6)
	out.fill(0)
	out.encode_s8(0, SerialUtils.float_to_s8(sweetness))
	out.encode_s8(1, SerialUtils.float_to_s8(bitterness))
	out.encode_s8(2, SerialUtils.float_to_s8(sourness))
	out.encode_s8(3, SerialUtils.float_to_s8(saltiness))
	out.encode_s8(4, SerialUtils.float_to_s8(umami))
	out.encode_s8(5, SerialUtils.float_to_s8(spiciness))
	return out

static func deserialise(data: PackedByteArray) -> Flavour:
	var flavour := Flavour.new()
	flavour.sweetness = SerialUtils.s8_to_float(data.decode_s8(0))
	flavour.bitterness = SerialUtils.s8_to_float(data.decode_s8(1))
	flavour.sourness = SerialUtils.s8_to_float(data.decode_s8(2))
	flavour.saltiness = SerialUtils.s8_to_float(data.decode_s8(3))
	flavour.umami = SerialUtils.s8_to_float(data.decode_s8(4))
	flavour.spiciness = SerialUtils.s8_to_float(data.decode_s8(5))
	return flavour