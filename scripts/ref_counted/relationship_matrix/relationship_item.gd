extends RefCounted
class_name RelationshipItem

const FAMILY_MASK: int = 0b1_0000000

## Add more relationship types later
enum RelationshipType {
	NEUTRAL = 0,
	FRIEND = 1,
	ENEMY = 2,
	SIBLING = 0 | FAMILY_MASK,
	CHILD = 1 | FAMILY_MASK,
	PARENT = 2 | FAMILY_MASK,
	AUNT = 3 | FAMILY_MASK,
	UNCLE = 4 | FAMILY_MASK,
	COUSIN = 5 | FAMILY_MASK,
	GRANDPARENT = 6 | FAMILY_MASK,
	GRANDCHILD = 7 | FAMILY_MASK,
	RELATIVE = 8 | FAMILY_MASK, # Generic family member
}


var relationship_strength: float
var relationship_type: RelationshipType


func _init(_relationship_strength: float, _relationship_type: RelationshipType) -> void:
	self.relationship_strength = _relationship_strength
	self.relationship_type = _relationship_type


static func is_family(_relationship_type: RelationshipType) -> bool:
	return _relationship_type & FAMILY_MASK != 0
