extends Node3D
@onready var worldNode : Node = $".."

@export var playerFaction : Node3D
@export var hellFaction : Node3D
@export var environmentFaction : Node3D

@onready var factionArray : Array = [playerFaction, hellFaction, environmentFaction]

@export var activeIndex : int = 0

@onready var activePlayer : Node3D = factionArray[activeIndex]






func passTurn():
	activePlayer.endTurn()
	activeIndex += 1
	if activeIndex >= factionArray.size():
		activeIndex = 0
	activePlayer = factionArray[activeIndex]
	printActiveUnits()

func passTurnTo(newIndex: int):
	activePlayer.endTurn()
	activeIndex = newIndex
	if activeIndex >= factionArray.size():
		print("passTurnTo() encountered an out of bounds error!")
	activePlayer = factionArray[activeIndex]
	printActiveUnits()

func printActiveUnits():
	print("active index: ", activeIndex)
	print("active player: ", activePlayer)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
