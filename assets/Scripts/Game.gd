extends Node2D

@onready var label = $TimerLabel
@onready var timer = $Timer

var CurMinigame

var last_recorded_time
var time_to_wait

var input

var CurMinigameHolder7
var CurMinigameHolder4
var CurMinigameHolder1

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	preload_minigames()
	input = get_node("Input")
	connect_input()
	CurMinigame = get_node("OrderScreen")
	CurMinigame.input = input
	CurMinigame.connect_input()
	CurMinigame.ScoreReturn.connect(_update_score)
	randomize()
	randomize_next_minigame_time()
	$ScoreVal.text = "0"
	timer.start()

func time_left_for_timer():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _process(delta):
	label.text = "%01d:%02d" % time_left_for_timer()
	if(timer.time_left < last_recorded_time - time_to_wait):
		if($Minigames/MinigameSelection7/Input.text == ""):
			CurMinigameHolder7 = initialize_minigame()
			$Minigames/MinigameSelection7/Input.text = CurMinigameHolder7.title
		elif($Minigames/MinigameSelection4/Input.text == ""):
			CurMinigameHolder4 = initialize_minigame()
			$Minigames/MinigameSelection4/Input.text = CurMinigameHolder4.title
		elif($Minigames/MinigameSelection1/Input.text == ""):
			CurMinigameHolder1 = initialize_minigame()
			$Minigames/MinigameSelection1/Input.text = CurMinigameHolder1.title
		randomize_next_minigame_time()

func randomize_next_minigame_time():
	last_recorded_time = timer.time_left
	time_to_wait = randf_range(3,5)

func _on_timer_timeout():
	game_over()

func game_over():
	pass

func connect_input():
	input.input.connect(_on_input_received)

func _update_score(input):
	score += input
	$ScoreVal.text = str(score)
	$ScoreChangeText.text = "+" + str(input)

func preload_minigames():
	load("res://assets/GDResources/Minigames/IceCreamScoop.tres")
	load("res://assets/GDResources/Minigames/Cake.tres")
	load("res://assets/GDResources/Minigames/Popsicle.tres")

func initialize_minigame():
	var output
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, 2)
	match num:
		0:
			output = load("res://assets/GDResources/Minigames/IceCreamScoop.tres")
		1:
			output = load("res://assets/GDResources/Minigames/Cake.tres")
		2:
			output = load("res://assets/GDResources/Minigames/Popsicle.tres")
	return output

func _on_input_received(keycode):
	match keycode:
		"7":
			if($Minigames/MinigameSelection7/Input.text != ""):
				CurMinigame.CurMinigameAttribute = CurMinigameHolder7
				CurMinigame.activate_minigame()
				$Minigames/MinigameSelection7/Input.text = ""
				CurMinigameHolder7 = null
		"4":
			if($Minigames/MinigameSelection4/Input.text != ""):
				CurMinigame.CurMinigameAttribute = CurMinigameHolder4
				CurMinigame.activate_minigame()
				$Minigames/MinigameSelection4/Input.text = ""
				CurMinigameHolder4 = null
		"1":
			if($Minigames/MinigameSelection1/Input.text != ""):
				CurMinigame.CurMinigameAttribute = CurMinigameHolder1
				CurMinigame.activate_minigame()
				$Minigames/MinigameSelection1/Input.text = ""
				CurMinigameHolder1 = null
