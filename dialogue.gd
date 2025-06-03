extends Control
class_name DialogueSystem

@onready var content = get_node("Content") as RichTextLabel
@onready var type_timer = get_node("TypeTimer") as Timer

signal message_complete()

func _ready() -> void:
	update_message("[color=black][wave amplitude=5]This is a text box with dialogue and {PLAYER}'s name in it![/wave][/color]")

func update_message(message) -> void:
	content.text = message
	content.visible_characters = 0
	type_timer.start()

func _on_type_timer_timeout() -> void:
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()
		message_complete.emit()
