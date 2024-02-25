extends Node

var validationNode

var input

var CurMinigameAttribute

var CurOrder

var CurOrderFilled = []

var blips = []

signal ScoreReturn(score)

func _ready():
	blips.append(load("res://assets/sfx/blip1.wav"))
	blips.append(load("res://assets/sfx/blip5.wav"))
	blips.append(load("res://assets/sfx/blip7.wav"))
	blips.append(load("res://assets/sfx/blip9.wav"))
	pass

func _process(delta):
	pass

func randomize_order():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, CurMinigameAttribute.OrderList.size()-1)
	CurOrder = CurMinigameAttribute.OrderList[num]

func _on_input_received(keycode):
	if(!self.visible):
		return
	if(has_node("BottomPanel/HBoxContainer"+keycode)):
		add_ingredient(get_node("BottomPanel/HBoxContainer"+keycode+"/Input").text, keycode)
		play_random_blip()
		return
	match keycode:
		"#":
			deactivate_minigame()

func add_ingredient(input, keycode):
	if(input != ""):
		CurOrderFilled.append(get_node("BottomPanel/HBoxContainer"+keycode+"/Input").text)

func connect_input():
	input.input.connect(_on_input_received)

func validation():
	var tempCurOrder = CurOrder.OrderDetails.duplicate()
	var tempScore = 0
	var targetScore = tempCurOrder.size()
	if(CurOrder.OrderMatters):
		for i in tempCurOrder.size():
			if (CurOrderFilled[i] == tempCurOrder[i]):
				tempScore += 1
			else:
				tempScore -= 1
	else:
		tempScore = targetScore
		for i in CurOrderFilled.size():
			if(tempCurOrder.has(CurOrderFilled[i])):
				tempCurOrder.erase(CurOrderFilled[i])
				tempScore += 1
		tempScore -= tempCurOrder.size()
		
	
	return tempScore

#Make the order screen active and attach all labels
func activate_minigame():
	randomize_order()
	clear_fields()
	fill_fields()
	self.visible = true

func fill_fields():
	var ingredient_field_list = $BottomPanel.get_children()
	for i in CurOrder.ingredientList.size():
		ingredient_field_list[i].get_node("Input").text = CurOrder.ingredientList[i]
	for i in CurOrder.OrderDetails:
		$Instructions.text += i + "\n"

func clear_fields():
	for i in $BottomPanel.get_children():
		i.get_node("Input").text = ""
	$Instructions.text = ""

func play_random_blip():
	var audioplayer := $"../AudioPlayer" as AudioStreamPlayer2D
	if(audioplayer.is_playing()):
		audioplayer.stop()
			
	audioplayer.stream = blips.pick_random()
	audioplayer.play()

func play_result_sfx(score, targetScore):
	var audioplayer := $"../AudioPlayer" as AudioStreamPlayer2D
	if(audioplayer.is_playing()):
		audioplayer.stop()	
	if(score < targetScore):
		
		audioplayer.stream = load("res://assets/sfx/good2.wav")
	else:
		audioplayer.stream = load("res://assets/sfx/good1.wav")
	audioplayer.play()
		

func deactivate_minigame():
	self.visible = false
	emit_signal("ScoreReturn", validation())
