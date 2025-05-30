extends RefCounted
class_name IslanderState

# TODO: Store current location, current activity, event queue

var islander_id: int

const HOURS_TO_DRAIN_HUNGER: float = 1.0
const SECONDS_TO_DRAIN_HUNGER: float = HOURS_TO_DRAIN_HUNGER * 60 * 60

const HOURS_TO_DRAIN_ENERGY: float = 0.2
const SECONDS_TO_DRAIN_ENERGY: float = HOURS_TO_DRAIN_ENERGY * 60 * 60

const MINUTES_TO_REGAIN_ENERGY_AT_HOME: float = 30
const SECONDS_TO_REGAIN_ENERGY_AT_HOME: float = MINUTES_TO_REGAIN_ENERGY_AT_HOME * 60

const HOURS_TO_DRAIN_HUNGER_SLEEPING: int = 9
const SECONDS_TO_DRAIN_HUNGER_SLEEPING: int = HOURS_TO_DRAIN_HUNGER_SLEEPING * 60 * 60

const MAX_REQUESTS: int = 5

## The amount of energy per second an islander loses if not
## at home
const BASE_ENERGY_DRAIN: float = 1.0 / SECONDS_TO_DRAIN_ENERGY

## How much hunger an islander loses
## per second, assuming they are not exercising
## or sleeping
const BASE_HUNGER_DRAIN: float = 1.0 / SECONDS_TO_DRAIN_HUNGER

const AT_HOME_ENERGY_GAIN: float = 1.0 / SECONDS_TO_REGAIN_ENERGY_AT_HOME
const SLEEP_ENERGY_GAIN: float = 5.0 / SECONDS_TO_REGAIN_ENERGY_AT_HOME
const SLEEP_HUNGER_DRAIN: float = 1.0 / SECONDS_TO_DRAIN_HUNGER_SLEEPING

## How long this islander can do activities before needing to return home
var energy: float
## How much food can this islander eat before being full
var hunger: float

## How close is this islander to levelling up
var happiness: float
var level: int

var money: int

var last_request_time: int

var current_location_id: int
var current_activity: StringName

var request_queue: Array[BaseRequest] = []

func _init() -> void:
	energy = 1.0
	hunger = 0.8
	happiness = 0.0
	level = 1
	money = 0
	
	last_request_time = roundi(Time.get_unix_time_from_system())
	current_activity = ActivityID.IDLE

func at_home() -> bool:
	return GameState.get_islander(islander_id).profile.home_location_id == current_location_id
	
func is_sleeping() -> bool:
	return current_activity == ActivityID.SLEEPING

func update(personality: Personality, delta: float) -> void:
	var energy_update: float = 0.0
	var hunger_update: float = -BASE_HUNGER_DRAIN


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

func has_max_requests_of_type(request_type: BaseRequest.RequestType) -> bool:
	## Check if the request queue has the maximum number of requests of the given type
	var count: int = 0
	for request in request_queue:
		if request.type == request_type:
			count += 1
	if count >= BaseRequest.MAX_REQUEST_OF_TYPE[request_type]:
		return true
	return false

func generate_request() -> void:

	var now = roundi(Time.get_unix_time_from_system())
	var new_request: BaseRequest = null

	if request_queue.size() >= MAX_REQUESTS:
		## Max requests, so don't generate more and reset the last request time
		last_request_time = now
		return
	
	## TODO: Work out rules for what kind of requests can be generated. For now, just add food requests
	## Will need to make sure that requests are random. Also possibly reduce the chance of requests
	## generating

	if hunger < 0.8:
		if has_max_requests_of_type(BaseRequest.RequestType.FOOD):
			## Already have max food requests, so don't generate more
			last_request_time = now
			return
		new_request = FoodRequest.new(islander_id)

	
	
	if new_request == null:
		## No request generated, so don't update the last request time
		return

	## Priority 0 requests are always added to the end of the queue
	if new_request.priority == 0 or request_queue.size() == 0:
		request_queue.push_back(new_request)
	else:
		for i in range(request_queue.size()):
			if request_queue[i].priority < new_request.priority:
				request_queue.insert(i, new_request)
				break
		request_queue.push_back(new_request)
		
	last_request_time = now
	

	
