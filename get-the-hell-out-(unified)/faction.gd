extends Node3D

@export var displayName : String
@export var isHuman : bool = false
var isActive : bool

var unitArray : Array

var activeUnit

signal endTurnSignal

func endTurn():
	endTurnSignal.emit()
	pass
	
func initTurn():
	print(name," initTurn")
	for unit in unitArray:
		unit.initTurn()
		unit.wait = false
	if not isHuman:
		activeUnit = unitArray.pick_random()
		
func handleTurn():
	if not isHuman:
		endTurn()
	if activeUnit and activeUnit.wait:
		activeUnit = unitArray.filter(func(element) : return element.wait == false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.get("type") == "unit":
			unitArray.append(child)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
