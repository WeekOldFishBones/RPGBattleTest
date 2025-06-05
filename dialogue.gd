extends Control
class_name DialogueSystem

var player_dict = {"name": "Morgan"}
var enemy_dict = {"name": "Great King Crow"}

@onready var content = get_node("Content") as RichTextLabel
@onready var type_timer = get_node("TypeTimer") as Timer

signal message_complete()

var replacement_regex = RegEx.new()
var message_array = []
var replacement_dict = {
	"{PLAYER}": player_dict.name,
	"{ENEMY}": enemy_dict.name
}
var output_message

func _ready() -> void:
	update_message("[color=black][wave amplitude=5]This is a text box with dialogue, {PLAYER}'s name, and {ENEMY}'s name in it![/wave][/color]")

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

func placeholder_splitter(message):
	replacement_regex.compile(\{[^}]*\})
	pass

func replace_placeholders(input_array : Array, replacements : Dictionary):
	message_array = input_array
	replacement_dict = replacements
	pass
