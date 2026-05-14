extends Control

@onready var player = $".."

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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
