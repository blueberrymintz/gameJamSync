extends Control


@onready var Player1Button = $playerSelect/player1
@onready var Player2Button = $playerSelect/player2
@onready var Player3Button = $playerSelect/player3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _attack_pressed() -> void:
	print("attack pressed")
	
	
func _move_pressed() -> void:
	print("move pressed")
	
	
	
func _next_pressed() -> void:
	print("next pressed")
	
	
	
func _player_1_pressed() -> void:
	#most absolute janky setup. change later
	#for now it just sets the button that's clicked to disabled
	#and all the other ones to enabled
	#should check if the other players are dead in the future
	Player1Button.set_disabled(true)
	Player2Button.set_disabled(false)
	Player3Button.set_disabled(false)
	
	print("player 1 pressed")
	
	
	
func _player_2_pressed() -> void:
	Player2Button.set_disabled(true)
	Player1Button.set_disabled(false)
	Player3Button.set_disabled(false)
	print("player 2 pressed")
	
	
func _player_3_pressed() -> void:
	Player3Button.set_disabled(true)
	Player1Button.set_disabled(false)
	Player2Button.set_disabled(false)
	print("player 2 pressed")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
