extends Node3D

@onready var occupied = $Occupied
@onready var green_material = preload("res://assets_3d/green_material_3d.tres")
@onready var selected : bool = true
var type = "terrain"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_occupied_body_entered(body: Node3D) -> void:
	print(body.name)
	#set_surface_override_material(0, green_material) # Replace with function body.
