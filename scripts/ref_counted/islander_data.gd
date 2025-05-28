extends RefCounted
class_name IslanderData


var islander_id: int
var profile: IslanderProfile
var state: IslanderState
var mesh: Mesh

# TODO: Store inventory, relationships, history

func _init() -> void:
	islander_id = GameState.generate_islander_id()
	state.islander_id = islander_id
	profile.islander_id = islander_id

func update_state(delta: float) -> void:
	state.update(profile.personality, delta)
