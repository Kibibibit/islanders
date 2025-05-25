extends Object
class_name SerialUtils


const MAX_NAME_LEN: int = 32

## maps the float between -1.0 and 1.0 to the closet byte value between -100 and 100
static func float_to_s8(v: float) -> int:
	if v < -1.0 or v > 1.0:
		push_error("Value out of range: %s" % v)
		return 0
	return int(round(v * 100))

static func s8_to_float(v: int) -> float:
	if v < -100 or v > 100:
		push_error("Value out of range: %s" % v)
		return 0.0
	return float(v) / 100.0

## maps the float between 0.0 and 1.0 to the closest byte value between 0 and _max
static func float_to_u8(v: float, _max: int = 255) -> int:
	if v < 0.0 or v > 1.0:
		push_error("Value out of range: %s" % v)
		return 0
	return int(round(v * _max))

static func u8_to_float(v: int, _max: int = 255) -> float:
	if v < 0 or v > _max:
		push_error("Value out of range: %s" % v)
		return 0.0
	return float(v) / float(_max)

static func memcpy(src: PackedByteArray, dst: PackedByteArray, src_offset: int = 0, dst_offset: int = 0, size: int = -1) -> void:
	if size == -1:
		size = src.size() - src_offset
	dst.resize(dst.size() + size)
	for i in range(size):
		dst[dst_offset + i] = src[src_offset + i]
