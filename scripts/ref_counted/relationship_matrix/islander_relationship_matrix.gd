extends RefCounted
class_name IslanderRelationshipMatrix

## Represents a matrix of relationships between islanders.
# relationships are also not bidirectional, so islander_id_a -> islander_id_b is not the same as islander_id_b -> islander_id_a, 
# however relationship types are.

var matrix: Dictionary[int, IslanderRelationshipMatrixRow] = {} # islander_id -> IslanderRelationshipMatrixRow Map


var _unknown: Relationship = Relationship.new(0.0, Relationship.RelationshipType.NEUTRAL) # Default relationship for unknown islanders

func get_relationship(islander_id_a: int, islander_id_b: int) -> Relationship:
	assert(islander_id_a != islander_id_b, "Cannot get relationship with self")

	if not matrix.has(islander_id_a):
		return _unknown
	
	var row: IslanderRelationshipMatrixRow = matrix[islander_id_a]
	if not row.relationships.has(islander_id_b):
		return _unknown
	
	return row.relationships[islander_id_b]

func set_relationship_type(islander_id_a: int, islander_id_b: int, relationship: Relationship.RelationshipType) -> void:
	assert(islander_id_a != islander_id_b, "Cannot set relationship with self")

	if not matrix.has(islander_id_a):
		matrix[islander_id_a] = IslanderRelationshipMatrixRow.new()
	
	var row: IslanderRelationshipMatrixRow = matrix[islander_id_a]
	if not row.relationships.has(islander_id_b):
		row.relationships[islander_id_b] = Relationship.new(0.0, relationship)
	else:
		row.relationships[islander_id_b].relationship_type = relationship
	
	if not matrix.has(islander_id_b):
		matrix[islander_id_b] = IslanderRelationshipMatrixRow.new()
	var reverse_row: IslanderRelationshipMatrixRow = matrix[islander_id_b]
	if not reverse_row.relationships.has(islander_id_a):
		reverse_row.relationships[islander_id_a] = Relationship.new(0.0, relationship)
	else:
		reverse_row.relationships[islander_id_a].relationship_type = relationship

func set_relationship_strength(islander_id_a: int, islander_id_b: int, strength: float) -> void:
	assert(islander_id_a != islander_id_b, "Cannot set relationship with self")

	if not matrix.has(islander_id_a):
		matrix[islander_id_a] = IslanderRelationshipMatrixRow.new()
	
	var row: IslanderRelationshipMatrixRow = matrix[islander_id_a]
	if not row.relationships.has(islander_id_b):
		row.relationships[islander_id_b] = Relationship.new(strength, Relationship.RelationshipType.NEUTRAL)
	else:
		row.relationships[islander_id_b].relationship_strength = strength

func get_relationship_count(islander_id: int) -> int:
	if not matrix.has(islander_id):
		return 0
	
	var row: IslanderRelationshipMatrixRow = matrix[islander_id]
	return row.relationships.size()
