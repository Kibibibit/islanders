extends Control
class_name DialogBox

signal _next_pressed

const DEFAULT_SPEED: float = 0.005

@onready
var text_label = %DialogBoxText
@onready
var timer = %DialogBoxTimer
@onready
var blinker = %DialogBoxBlinker
@onready
var blinker_timer = %DialogBoxBlinkerTimer

var _speed: float = 0.0
var _text: String
var displayed_index: int = 0
var in_tag: bool = false
var finished_text: bool = false

func _ready() -> void:
	visible = false
	blinker_timer.timeout.connect(_alternate_blinker)

func clear() -> void:
	text_label.text = ""
	displayed_index = 0
	in_tag = false
	blinker.visible = false
	finished_text = false
	blinker_timer.stop()
	timer.stop()

func _unhandled_input(event: InputEvent) -> void:
	if not finished_text:
		if event.is_action_pressed("dialog_skip"):
			timer.stop()
			timer.timeout.emit()
			displayed_index = len(_text)
			_on_text_finish()
	else:
		if event.is_action_pressed("dialog_next") or event.is_action_pressed("dialog_skip"):
			_next_pressed.emit()
	

func display_text(text: String, speed: float = -1.0) -> void:
	visible = true
	clear()
	_text = text
	if (speed < 0.0):
		_speed = DEFAULT_SPEED
	displayed_index = 0
	var i: int = 1
	while displayed_index < len(_text):
		if not in_tag:
			if _text[displayed_index] == "[":
				in_tag = true
		else:
			if _text[displayed_index+i] == "]":
				i += 1
				in_tag = false
		if not in_tag:
			text_label.append_text(_text.substr(displayed_index, i))
			displayed_index += i
			i = 1
			await _trigger_timer()
		else:
			i += 1
	_on_text_finish()
	await self._next_pressed
	clear()
	self.visible = false

func _on_text_finish():
	if visible and not finished_text:
		text_label.text = _text
		finished_text = true
		blinker.visible = true
		blinker_timer.start()

func _alternate_blinker() -> void:
	if finished_text:
		blinker.visible = !blinker.visible
	else:
		blinker.visible = false

func _trigger_timer() -> void:
	timer.start(_speed)
	await timer.timeout
	
