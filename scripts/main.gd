extends Node


func _ready() -> void:
	
	GameState.ui = $Ui
	
	
	var test_islander: IslanderData = IslanderData.new()
	test_islander.profile.first_name = "Hi im a name"
	GameState.islanders[test_islander.islander_id] = test_islander
		
	GameState.island_name = "hi_there"
	
	Timekeeper.loaded_data = true
	Timekeeper.start()
	
	await GameState.ui.display_text("""lorem ipsum dolar [b]SIT amet[/b] [i]This is some italic text[/i] [color=red]text is red![/color]
Text is [b][shake rate=20.0 level=5 connected=1]shakey wooooooo[/shake][/b]""")
	
	await GameState.ui.display_text("""Even more text!""")
