extends RefCounted
class_name ColorProfile

const SIZE: int = 4*6 # Hex rgb is 4 bytes

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


func serialise() -> PackedByteArray:
	var out := PackedByteArray()
	out.resize(SIZE)
	out.fill(0)
	out.encode_u32(0, serialise_color(favourite_color))
	out.encode_u32(4, serialise_color(hair_color))
	out.encode_u32(8, serialise_color(skin_color))
	out.encode_u32(12, serialise_color(pupil_eye_color))
	out.encode_u32(16, serialise_color(iris_eye_color))
	out.encode_u32(20, serialise_color(lip_color))
	return out

static func deserialise(data: PackedByteArray) -> ColorProfile:
	var out := ColorProfile.new()
	out.favourite_color = deserialise_color(data.slice(0, 4))
	out.hair_color = deserialise_color(data.slice(4, 8))
	out.skin_color = deserialise_color(data.slice(8, 12))
	out.pupil_eye_color = deserialise_color(data.slice(12, 16))
	out.iris_eye_color = deserialise_color(data.slice(16, 20))
	out.lip_color = deserialise_color(data.slice(20, 24))
	return out

static func serialise_color(c: Color) -> int:
	var out := 0
	out |= SerialUtils.float_to_u8(c.r, 255) << 24
	out |= SerialUtils.float_to_u8(c.g, 255) << 16
	out |= SerialUtils.float_to_u8(c.b, 255) << 8
	out |= SerialUtils.float_to_u8(c.a, 255)
	return out

static func deserialise_color(data: PackedByteArray) -> Color:
	var r := SerialUtils.u8_to_float(data.decode_u8(0), 255)
	var g := SerialUtils.u8_to_float(data.decode_u8(1), 255)
	var b := SerialUtils.u8_to_float(data.decode_u8(2), 255)
	var a := SerialUtils.u8_to_float(data.decode_u8(3), 255)
	return Color(r, g, b, a)
