extends Node3D

var gameOver:bool = false
var turnArray:Array = ["player", "ai", "environment"]

func turnNext():
	pass

func nextTurn():
	if gameOver:
		return
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
