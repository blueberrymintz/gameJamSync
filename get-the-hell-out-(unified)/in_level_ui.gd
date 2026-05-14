extends Control

@onready var player = $".."
@onready var Player1Button = $HBoxContainer/player_1_button
@onready var Player2Button = $HBoxContainer/player_2_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _attack_pressed() -> void:
	if player.currentMode == "attack":
		player.currentMode = "select"
	else:
		player.currentMode = "attack"
	print("attack pressed")
	
	
func _move_pressed() -> void:
	if player.currentMode == "move":
		player.currentMode = "select"
	else:
		player.currentMode = "move"
	print("move pressed")
	
	
func _next_pressed() -> void:
	if player.currentMode == "next":
		player.currentMode = "select"
	else:
		player.currentMode = "next"
	print("next pressed")
	
func _player_1_pressed() -> void:
	#most absolute janky setup. change later
	#for now it just sets the button that's clicked to disabled
	#and all the other ones to enabled
	#should check if the other players are dead in the future
	
	Player1Button.grab_focus()
	
	print("player 1 pressed")
	
	
	
func _player_2_pressed() -> void:
	Player2Button.grab_focus()
	print("player 2 pressed")
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
