extends BaseRequest
class_name FoodRequest


const NO_SPECIFIC_FOOD: int = -1

const CHANCE_OF_SPECIFIC_FOOD: float = 0.05 # 5% chance of requesting a specific food
const CHANCE_OF_FLAVOUR: float = 0.1 # 10% chance of requesting a specific flavour

var requested_flavour: Flavour.FlavourType = Flavour.FlavourType.NONE
var requested_food_id: int = NO_SPECIFIC_FOOD


func _init(islander_id: int) -> void:

	var islander_data: IslanderData = GameState.get_islander(islander_id)

	var villager_hunger: float = islander_data.state.hunger
	if villager_hunger < 0.1:
		# Villager is very hungry so food takes priority
		# and they're not picky so we skip the random rolls
		priority = 100
	else:
		if villager_hunger < 0.5:
			priority = 1 # Villager is hungry but not starving, so food is important
		
		var roll: float = randf()
		if roll < CHANCE_OF_SPECIFIC_FOOD:
			pass
			## TODO: Implement logic to get a specific food item, most likely
			## from either the villagers favourite food/flavour
		elif roll < CHANCE_OF_FLAVOUR:
			# Villager is requesting a specific flavour
			## TODO: Implement logic to get villager to want their preferred flavour more
			requested_flavour = randi_range(0, Flavour.FlavourType.NONE - 1) as Flavour.FlavourType





func _get_request_type() -> RequestType:
	return RequestType.FOOD

func get_request_message(islander_id: int) -> String:
	if requested_food_id == NO_SPECIFIC_FOOD and requested_flavour == Flavour.FlavourType.NONE:
		if priority == 100:
			## TODO: Implement logic for getting personality specific dialogue.
			## Good luck with that future me. Maybe PO files?
			## Just make sure to implement _something_ so it's not too hard
			## to extend before you add too many lines
			return "I'm starving!"
		elif priority > 0:
			return "I'm really hungry!"
		else:
			return "I'm a bit hungry."
	elif requested_food_id != NO_SPECIFIC_FOOD:
		return "I want some food, specifically food with ID %d." % requested_food_id
	elif requested_flavour != Flavour.FlavourType.NONE:
		return "I want food with a %d flavour." % requested_flavour
	else:
		push_error("Invalid request state for islander %d: requested_food_id=%d, requested_flavour=%s" % [islander_id, requested_food_id, str(requested_flavour)])
		# This shouldn't happen but it can be a fun little easter egg
		return "...What? Something broke but I'd like some food please."
