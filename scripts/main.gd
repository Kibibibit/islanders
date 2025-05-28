extends Node


func _ready() -> void:
	
	for i in range(10):
		var test_islander: IslanderData = IslanderData.new()
		test_islander.profile = IslanderProfile.new()
		test_islander.state = IslanderState.new()
		test_islander.profile.first_name = "Hi im a name"
		GameState.islanders[test_islander.id] = test_islander
		
		
	GameState.island_name = "hi_there"
	
	
	
	
