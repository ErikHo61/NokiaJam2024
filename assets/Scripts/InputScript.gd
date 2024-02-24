extends Node

signal input(keycode)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("kp 1")):
		emit_signal("input", "1")
	if(Input.is_action_just_pressed("kp 2")):
		emit_signal("input", "2")
	if(Input.is_action_just_pressed("kp 3")):
		emit_signal("input", "3")
	if(Input.is_action_just_pressed("kp 4")):
		emit_signal("input", "4")
	if(Input.is_action_just_pressed("kp 5")):
		emit_signal("input", "5")
	if(Input.is_action_just_pressed("kp 6")):
		emit_signal("input", "6")
	if(Input.is_action_just_pressed("kp 7")):
		emit_signal("input", "7")
	if(Input.is_action_just_pressed("kp 8")):
		emit_signal("input", "8")
	if(Input.is_action_just_pressed("kp 9")):
		emit_signal("input", "9")
	if(Input.is_action_just_pressed("kp 0")):
		emit_signal("input", "0")
	if(Input.is_action_just_pressed("kp dot")):
		emit_signal("input", "*")
	if(Input.is_action_just_pressed("kp enter")):
		emit_signal("input", "#")
	pass

