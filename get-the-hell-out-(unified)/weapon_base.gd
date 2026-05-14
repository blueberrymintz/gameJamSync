extends Node3D
@export var damage : int
@export var uses : int
@export var hitLocations : Array
var threatenedTiles : Node3D

func threaten(Vector3):
	if threatenedTiles:
		threatenedTiles.queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
