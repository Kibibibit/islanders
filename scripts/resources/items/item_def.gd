extends Resource
class_name ItemDef


enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY
}

enum ItemType {
	FOOD,
	CLOTHING,
	MISC,
	ERROR
}

@export
var name: String
@export
var price: int
@export
var rarity: Rarity

var type: ItemType:
	get:
		return _item_type()
	
func _item_type() -> ItemType:
	assert(false, "Bad item type! Did you forget to override _item_type?")
	return ItemType.ERROR
