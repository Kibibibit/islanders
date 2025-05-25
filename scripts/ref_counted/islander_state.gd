extends RefCounted
class_name IslanderState

# One byte for most fields, 8 bytes for money
const SIZE: int = 1 + 1 + 1 + 1 + 8

# TODO: Store current location, current activity, event queue

## The amount of energy per second an islander loses if not
## at home
const BASE_ENERGY_DRAIN: float = 0.1

## How much hunger an islander loses
## per second, assuming they are not exercising
## or sleeping
const BASE_HUNGER_DRAIN: float = 0.1

const AT_HOME_ENERGY_GAIN: float = 0.2
const SLEEP_ENERGY_GAIN: float = 0.8
const SLEEP_HUNGER_DRAIN: float = 0.05

var energy: float
var hunger: float
var happiness: float
var level: int

var money: int

var last_event_time: int

func _init() -> void:
	energy = 1.0
	hunger = 1.0
	happiness = 1.0
	level = 1
	money = 0


func update(personality: Personality, delta: float) -> void:
	var energy_update: float = 0.0
	var hunger_update: float = BASE_HUNGER_DRAIN


	if at_home():
		if is_sleeping():
			energy_update = SLEEP_ENERGY_GAIN
			hunger_update = -SLEEP_HUNGER_DRAIN
		else:
			energy_update = lerp(0.5, 1.5, personality.introverted) * AT_HOME_ENERGY_GAIN
	else:
		energy_update = -lerp(0.5, 1.5, 1.0 - personality.extroverted) * BASE_ENERGY_DRAIN
	
	energy += energy_update * delta * personality.energetic
	hunger += hunger_update * delta

	energy = clamp(energy, 0.0, 1.0)
	hunger = clamp(hunger, 0.0, 1.0)
	
func at_home() -> bool:
	## TODO: Actually check their position
	return true
func is_sleeping() -> bool:
	## TODO: Actually check their sleep state
	return false

func serialise() -> PackedByteArray:
	var out := PackedByteArray()
	out.resize(SIZE)
	out.fill(0)
	out.encode_s8(0, SerialUtils.float_to_u8(energy, 100))
	out.encode_s8(1, SerialUtils.float_to_u8(hunger, 100))
	out.encode_s8(2, SerialUtils.float_to_u8(happiness, 100))
	out.encode_s8(3, level)
	out.encode_u64(4, money)
	return out

static func deserialise(data: PackedByteArray) -> IslanderState:
	var out := IslanderState.new()
	out.energy = SerialUtils.u8_to_float(data.decode_u8(0), 100)
	out.hunger = SerialUtils.u8_to_float(data.decode_u8(1), 100)
	out.happiness = SerialUtils.u8_to_float(data.decode_u8(2), 100)
	out.level = data.decode_u8(3)
	out.money = data.decode_u64(4)
	return out