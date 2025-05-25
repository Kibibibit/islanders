extends Object
class_name MathsUtils


static func float_to_percentage(v: float) -> int:
	assert(0.0 <= v and v <= 1.0, "Float must be between 0 and 1")
	return floori(v*100.0)
static func percentage_to_float(v: int) -> float:
	assert(0 <= v and v <= 100, "Percentage must be between 0 and 100")
	return float(v)/100.0
