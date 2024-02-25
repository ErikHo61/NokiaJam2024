extends Node2D

var options = ["Start", "Exit"]
var selector = 0

func _input(event):
	if event.is_action_pressed("kp 2") || event.is_action_pressed("kp 8"): # down
		if selector==0:
			selector=1
			var child := $Start as RichTextLabel
			child.text = "Start"
			var child2 := $Exit as RichTextLabel
			child2.text = ">Exit"
			print("selector is %d", selector )
		else:
			selector=0
			var child := $Start as RichTextLabel
			child.text = ">Start"
			var child2 := $Exit as RichTextLabel
			child2.text = "Exit"
			print("selector is %d", selector )
		
	if event.is_action_pressed("kp enter"): # enter
			if selector==0:
				get_tree().change_scene_to_file("res://scene/Game.tscn")
			else:
				get_tree().quit()
