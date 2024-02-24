extends Node

var score = 0
var targetScore = 1

var inputHistory
var validationNode

var input


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_received(keycode):
	var button = get_parent().get_node("Container/RichTextLabel"+keycode)
	var button_original = button.name.substr(13, 1)
	button.set_text("&")
	await get_tree().create_timer(0.25).timeout
	button.set_text(button_original)

func connectInput():
	input.input.connect(_on_input_received)
