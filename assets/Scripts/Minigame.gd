extends Node

var score = 0
var targetScore = 1

var inputHistory
var validationNode

var input

var CurMinigameAttribute

var CurOrder

func _ready():
	load("res://assets/GDResources/Minigames/IceCreamScoop.tres")
	load("res://assets/GDResources/Minigames/Cake.tres")
	load("res://assets/GDResources/Minigames/Popsicle.tres")

func _process(delta):
	pass

func initialize_minigame():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, 2)
	match num:
		0:
			CurMinigameAttribute = load("res://assets/GDResources/Minigames/IceCreamScoop.tres")
		1:
			CurMinigameAttribute = load("res://assets/GDResources/Minigames/Cake.tres")
		2:
			CurMinigameAttribute = load("res://assets/GDResources/Minigames/Popsicle.tres")
	rng.randomize()
	num = rng.randi_range(0, CurMinigameAttribute.OrderList.size())
	CurOrder = CurMinigameAttribute.OrderList[num]
	print(CurOrder.OrderDetails)

func _on_input_received(keycode):
	pass

func connectInput():
	input.input.connect(_on_input_received)

#Make the order screen active and attach all labels
func activate_minigame():
	pass
