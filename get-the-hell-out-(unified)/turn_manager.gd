extends Node3D
@onready var worldNode : Node = $".."

@export var playerFaction : Node3D
@export var hellFaction : Node3D
@export var environmentFaction : Node3D

@onready var factionArray : Array = [playerFaction, hellFaction, environmentFaction]

var activeIndex : int = 0

@onready var activePlayer : Node3D = factionArray[activeIndex]

func passTurn():
	activePlayer.endTurn()
	activeIndex += 1
	if activeIndex >= factionArray.size():
		activeIndex = 0
	activePlayer = factionArray[activeIndex]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
