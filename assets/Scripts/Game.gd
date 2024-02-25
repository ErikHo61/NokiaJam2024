extends Node2D

@onready var label = $TimerLabel
@onready var timer = $Timer

var CurMinigame

var last_recorded_time
var time_to_wait

var input

# Called when the node enters the scene tree for the first time.
func _ready():
	input = get_node("Input")
	connectInput()
	CurMinigame = get_node("OrderScreen")
	randomize()
	randomize_next_minigame_time()
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
			CurMinigame.initialize_minigame()
			$Minigames/MinigameSelection7/Input.text = CurMinigame.CurMinigameAttribute.title
		elif($Minigames/MinigameSelection4/Input.text == ""):
			CurMinigame.initialize_minigame()
			$Minigames/MinigameSelection4/Input.text = CurMinigame.CurMinigameAttribute.title
		elif($Minigames/MinigameSelection1/Input.text == ""):
			CurMinigame.initialize_minigame()
			$Minigames/MinigameSelection1/Input.text = CurMinigame.CurMinigameAttribute.title
		randomize_next_minigame_time()

func randomize_next_minigame_time():
	last_recorded_time = timer.time_left
	time_to_wait = randf_range(3,6)

func _on_timer_timeout():
	game_over()

func game_over():
	pass

func connectInput():
	input.input.connect(_on_input_received)

func _on_input_received(keycode):
	match keycode:
		"7":
			if($Minigames/MinigameSelection7/Input.text != ""):
				pass
