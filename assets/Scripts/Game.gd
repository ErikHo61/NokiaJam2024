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

var CurMinigameTimer7: Timer
var CurMinigameTimer4: Timer
var CurMinigameTimer1: Timer

var TimerDifficulty = 12

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#load("res://assets/sfx/ring1.wav")
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
	
	CurMinigameTimer7 = $Minigames/MinigameSelection7/Timer
	CurMinigameTimer4 = $Minigames/MinigameSelection4/Timer
	CurMinigameTimer1 = $Minigames/MinigameSelection1/Timer
	
	CurMinigameTimer7.wait_time = TimerDifficulty
	CurMinigameTimer4.wait_time = TimerDifficulty
	CurMinigameTimer1.wait_time = TimerDifficulty

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
			$Minigames/MinigameSelection7/TimerLabel.text = "!"
			$Minigames/MinigameSelection7/Timer.wait_time = TimerDifficulty
			CurMinigameTimer7.start()
		elif($Minigames/MinigameSelection4/Input.text == ""):
			CurMinigameHolder4 = initialize_minigame()
			$Minigames/MinigameSelection4/Input.text = CurMinigameHolder4.title
			$Minigames/MinigameSelection4/TimerLabel.text = "!"
			$Minigames/MinigameSelection4/Timer.wait_time = TimerDifficulty
			CurMinigameTimer4.start()
		elif($Minigames/MinigameSelection1/Input.text == ""):
			CurMinigameHolder1 = initialize_minigame()
			$Minigames/MinigameSelection1/Input.text = CurMinigameHolder1.title	
			$Minigames/MinigameSelection1/TimerLabel.text = "!"
			$Minigames/MinigameSelection1/Timer.wait_time = TimerDifficulty
			CurMinigameTimer1.start()
			#if($AudioPlayer.is_playing()):
			#$AudioPlayer.stop()	
			#print("thing")
			#$AudioPlayer.stream = load("res://assets/sfx/ring1.wav")
			#$AudioPlayer.play()
		randomize_next_minigame_time()
	
	if (!CurMinigameTimer7.is_stopped()):
		$Minigames/MinigameSelection7/TimerLabel.text = timer_label_parsing(CurMinigameTimer7)

	if (!CurMinigameTimer4.is_stopped()):
		$Minigames/MinigameSelection4/TimerLabel.text = timer_label_parsing(CurMinigameTimer4)

	if (!CurMinigameTimer1.is_stopped()):
		$Minigames/MinigameSelection1/TimerLabel.text = timer_label_parsing(CurMinigameTimer1)

func _on_timer7_timeout():
	select_minigame7()
	_update_score(-4)

func _on_timer4_timeout():
	select_minigame4()
	_update_score(-4)

func _on_timer1_timeout():
	select_minigame1()
	_update_score(-4)

func select_minigame7():
	$Minigames/MinigameSelection7/Input.text = ""
	$Minigames/MinigameSelection7/TimerLabel.text = ""
	CurMinigameHolder7 = null
	CurMinigameTimer7.stop()

func select_minigame4():
	$Minigames/MinigameSelection4/Input.text = ""
	$Minigames/MinigameSelection4/TimerLabel.text = ""
	CurMinigameHolder4 = null
	CurMinigameTimer4.stop()

func select_minigame1():
	$Minigames/MinigameSelection1/Input.text = ""
	$Minigames/MinigameSelection1/TimerLabel.text = ""
	CurMinigameHolder1 = null
	CurMinigameTimer1.stop()

func timer_label_parsing(input):
	if input.time_left < TimerDifficulty / 3:
		return "!!!"
	elif input.time_left < TimerDifficulty * 2 / 3:
		return "!!"
	else:
		return "!"

func randomize_next_minigame_time():
	last_recorded_time = timer.time_left
	time_to_wait = randf_range(3,5)

func _on_timer_timeout():
	game_over()

func game_over():
	$GameOver.visible = true
	$GameOver/ScoreVal.text = str(score)

func restart():
	get_tree().reload_current_scene()

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
	load("res://assets/GDResources/Minigames/FrozenFruit.tres")

func initialize_minigame():
	var output
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, 3)
	match num:
		0:
			output = load("res://assets/GDResources/Minigames/IceCreamScoop.tres")
			#$FoodSprite.set_animation("IceCream")
		1:
			output = load("res://assets/GDResources/Minigames/Cake.tres")
			#$FoodSprite.set_animation("Cake")
		2:
			output = load("res://assets/GDResources/Minigames/Popsicle.tres")
			#$FoodSprite.set_animation("Popsicle")
		3:
			output = load("res://assets/GDResources/Minigames/FrozenFruit.tres")
			#$FoodSprite.set_animation("FrozenFruit")
	
	return output

func _on_input_received(keycode):
	if($OrderScreen.visible):
		return
	match keycode:
		"7":
			if($Minigames/MinigameSelection7/Input.text != ""):
				CurMinigame.CurMinigameAttribute = CurMinigameHolder7
				CurMinigame.activate_minigame()
				select_minigame7()
		"4":
			if($Minigames/MinigameSelection4/Input.text != ""):
				CurMinigame.CurMinigameAttribute = CurMinigameHolder4
				CurMinigame.activate_minigame()
				select_minigame4()
		"1":
			if($Minigames/MinigameSelection1/Input.text != ""):
				CurMinigame.CurMinigameAttribute = CurMinigameHolder1
				CurMinigame.activate_minigame()
				select_minigame1()
		_:
			if($GameOver.visible):
				restart()
