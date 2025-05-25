extends Node


func _ready() -> void:

	var test_islander: IslanderData = IslanderData.new()
	
	test_islander.profile = IslanderProfile.new()
	
	test_islander.profile.body_type = IslanderProfile.BodyType.B
	test_islander.profile.life_stage = IslanderProfile.LifeStage.ADULT
	
	var test_instance = Islander.create_scene()
	test_instance.data = test_islander
	
	add_child(test_instance)
