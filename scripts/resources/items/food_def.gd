extends ItemDef
class_name FoodDef

@export_range(0, 1, 0.01)
var food_value: float

var flavour: Flavour = Flavour.new()

@export_group("Flavour")
@export_range(-1.0, 1.0, 0.01)
var sweetness: float:
	get:
		return flavour.sweetness
	set(v):
		flavour.sweetness = v
@export_range(-1.0, 1.0, 0.01)
var bitterness: float:
	get:
		return flavour.bitterness
	set(v):
		flavour.bitterness = v
@export_range(-1.0, 1.0, 0.01)
var sourness: float:
	get:
		return flavour.sourness
	set(v):
		flavour.sourness = v
@export_range(-1.0, 1.0, 0.01)
var saltiness: float:
	get:
		return flavour.saltiness
	set(v):
		flavour.saltiness = v
@export_range(-1.0, 1.0, 0.01)
var umami: float:
	get:
		return flavour.umami
	set(v):
		flavour.umami = v
@export_range(-1.0, 1.0, 0.01)
var spiciness: float:
	get:
		return flavour.spiciness
	set(v):
		flavour.spiciness = v
		
func _item_type() -> ItemType:
	return ItemType.FOOD
