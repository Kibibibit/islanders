extends Control
class_name UI

@onready
var dialog_box: DialogBox = %DialogBox


func display_text(text: String, speed: float = -1.0) -> void:
	await dialog_box.display_text(text, speed)
