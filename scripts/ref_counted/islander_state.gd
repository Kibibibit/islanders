extends RefCounted
class_name IslanderState

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
