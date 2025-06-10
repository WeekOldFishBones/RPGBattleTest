extends Control
class_name DialogueSystem

var player_dict = {"name": "Morgan"}
var enemy_dict = {"name": "Great King Crow"}

@onready var content = get_node("Content") as RichTextLabel
@onready var type_timer = get_node("TypeTimer") as Timer

signal message_complete()

var replacement_regex = RegEx.new()
var replacement_dict = {
	"PLAYER": player_dict.name,
	"ENEMY": enemy_dict.name
}
var output_message

func _ready() -> void:
	update_message(replace_placeholders("[color=black][wave amplitude=5]This is a text box with dialogue, $PLAYER$'s name, and $ENEMY$'s name in it![/wave][/color]", replacement_dict))

#display text content in typewriter style
func _on_type_timer_timeout() -> void:
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()
		message_complete.emit()

#update content.text
func update_message(message) -> void:
	content.text = message
	content.visible_characters = 0
	type_timer.start()

#replace placeholders in input text
func replace_placeholders(message : String, replacements : Dictionary):
	var message_array = []
	#split message by placeholders and assign to message_array
	message_array = message.split("$", true, 0)
	print(message_array)
	#make a new_message_array to store the final string
	var output_message_array = []
	replacement_dict = replacements
	for i in message_array:
		if replacements.has(i):
			output_message_array.push_back(replacements.get(i))
		else:
			output_message_array.push_back(i)
	print(output_message_array)
	return "".join(output_message_array)
