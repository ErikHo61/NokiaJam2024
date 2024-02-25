extends Node

var input
var Active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func connectInput():
	input.input.connect(_on_input_received)

func _on_input_received(keycode):
	var button = get_node("Minigames/MinigameSelection"+keycode+"/Input")
	
