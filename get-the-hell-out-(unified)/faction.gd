extends Node3D

@export var displayName : String
@export var isHuman : bool = false
var isActive : bool

var unitArray

var activeUnit

func endTurn():
	pass
	
func initTurn():
	for unit in unitArray:
		unit.initTurn()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
