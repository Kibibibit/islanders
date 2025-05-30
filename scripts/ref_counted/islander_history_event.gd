extends RefCounted
class_name IslanderHistoryEvent
# Represents an event in an islander's history.


enum EventType {
	NONE,
	MEETING,
	CONVERSATION,
	FIGHT,
	NEW_FRIEND,
	NEW_ENEMY,
	NEW_LOVE,
	MARRIAGE,
	CHILD_BIRTH,
}

enum EventOutcome {
	NONE,
	POSITIVE,
	NEGATIVE,
	NEUTRAL,
}

var event_type: EventType = EventType.NONE
var event_outcome: EventOutcome = EventOutcome.NONE
var other_islanders: Array[int] = [] # List of islander IDs involved in the event
var timestamp: String = "" # Day and time this happened


func _init(_event_type: EventType, _event_outcome: EventOutcome,  _timestamp: String, _other_islanders: Array[int] = []) -> void:
	self.event_type = _event_type
	self.event_outcome = _event_outcome
	self.other_islanders = _other_islanders
	self.timestamp = _timestamp
