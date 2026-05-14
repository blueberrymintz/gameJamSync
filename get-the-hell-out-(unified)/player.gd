extends Node3D


@onready var camera = get_viewport().get_camera_3d()
var currentMode = "select"
var selectedUnit : Node3D


const RAY_LENGTH = 1000.0


func _input(event):
	
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = get_viewport().get_camera_3d()
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.new()
		var targetNode
		
		params.from = from
		params.to = to
		params.collide_with_areas = true  # Set to true to include Area nodes
		params.collide_with_bodies = true
		
		var result = space_state.intersect_ray(params)
		if result.is_empty():
			print("empty result")
		#elif result and result.collider and result.collider.is_class("Area3D"):
		#	print(result.collider.name)
		#	print(result.position)
		#	#updateTargetLoc(result.collider.global_position)
		#	print(result.collider.global_position)
		#	position = result.collider.global_position
			
		else: 
			print("Raycast hit:", result.collider.name)
			if result.collider.get("type"):
				print(result.collider.type)
				if result.collider.type == "terrain":
					print(result.collider.type)
				elif result.collider.type == "unit":
					if selectedUnit == result.collider:
						pass
					else:
						selectUnit(result.collider)
	
func selectUnit(unit):
	if selectedUnit != unit:
		if selectedUnit:
			selectedUnit.clearSelect()
		selectedUnit = unit
		selectedUnit.select()
	print(currentMode)
	

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
