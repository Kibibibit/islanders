extends Resource
class_name BaseRequestDef


## Base class for all requests
## Requests are used by villagers to ask for something from the player, like food,
## an item, or the player's opinion on something.
## Requests have a priority, but generally will be processed in the order they are received.

enum RequestType {
	FOOD,
	ITEM,
	QUESTION,
	ERROR
}


@export
var priority: int = 0 # Most requests will leave this at 0

@export
var name: String = "Base Request"

var type: RequestType:
	get:
		return _get_request_type()

func _init(islander_id: int) -> void:
	if islander_id < 0:
		push_error("Invalid islander ID: %d" % islander_id)
	

func _get_request_type() -> RequestType:
	return RequestType.ERROR

func get_request_message(islander_id: int) -> String:
	push_error("get_request_message not implemented for request: %s" % name)
	return "You've broken the game somehow! What are you doing here? My id is %d if you were curious" % islander_id

@warning_ignore("unused_parameter")
func get_happiness_change(islander_id: int) -> float:
	push_error("get_happiness_change not implemented for request: %s" % name)
	return 0.0
