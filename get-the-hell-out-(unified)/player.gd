extends Node3D


@onready var camera = get_viewport().get_camera_3d()
var currentMode = "select"
var selectedUnit : Node3D
var targetLoc: Vector3
var nextLoc: Vector3
var pathNode: Node3D

var current_path_index: int = 0
var current_path_point: Vector3
var current_path: PackedVector3Array
@onready var overlayNode = preload("res://assets_3d/overlay_tile.tscn")
var pathByNode :Array
@onready var uiCall = $"in_level_UI"
@onready var moveLabel = $"in_level_UI/moveCount"

var funresult

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
					if currentMode == "move" and pathByNode.size() - 2 < selectedUnit.movement:
						selectedUnit.position = targetLoc
						print(selectedUnit.movement)
						selectedUnit.movement -= pathByNode.size() - 1
						print(selectedUnit.movement)
						if pathNode:
							pathNode.queue_free()
				elif result.collider.type == "unit" and currentMode == "select":
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
		
func checkRealDistance(checkPoint: Vector3):
	var space_state = get_world_3d().direct_space_state
	var param = PhysicsPointQueryParameters3D.new()
	param.position = Vector3(checkPoint.x, 0, checkPoint.z)
	param.collision_mask = 0b1000
	param.collide_with_areas = true
	param.collide_with_bodies = false
	funresult = space_state.intersect_point(param)
	print(funresult)
	return funresult

func set_movement_target(target_position: Vector3):
	if not selectedUnit:
		return
	targetLoc = target_position
	var start_position: Vector3 = selectedUnit.global_position
	var agent = selectedUnit.get_node("NavigationAgent3D")

	current_path = NavigationServer3D.map_get_path(
		agent.get_navigation_map(),
		start_position,
		target_position,
		false
	)
	pathByNode = []
	if not current_path.is_empty():
		current_path_index = 0
		current_path_point = current_path[0]
		if pathNode:
			pathNode.queue_free()
		pathNode = Node3D.new()
		add_child(pathNode)
		print(current_path.size())
		for pathPoint in current_path:
			var stuffs = checkRealDistance(pathPoint)
			for uniqueNode in stuffs:
				if not uniqueNode.collider_id in pathByNode:
					pathByNode.append(uniqueNode.collider_id)
					var locationVector = uniqueNode.collider.global_position
					if pathByNode.size() - 2 < selectedUnit.movement and not pathByNode.size() == 1:
						var instance = overlayNode.instantiate()
						instance.transform.origin = Vector3(locationVector.x, .2, locationVector.z)
						pathNode.add_child(instance)
		print(selectedUnit.movement)
		print(pathByNode.size())
		
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _passMovementAmount() -> void:
	if(currentMode == "move"):
		moveLabel.updateLabel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pathNode and not currentMode == "move":
		pathNode.queue_free()
	if pathNode and not selectedUnit:
		pathNode.queue_free()
	if $in_level_UI/turnManager.activePlayer.isHuman and currentMode == "move":
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.global_position
		var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * RAY_LENGTH
		var param = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		var result = camera.get_world_3d().direct_space_state.intersect_ray(param)
		#if result:
			#print(result.collider.name)
		if result and selectedUnit and result.collider.get("type") == "terrain":
			if not targetLoc == result.collider.position:
				print("settingNewTarget")
				set_movement_target(result.collider.position)
			
		
	pass
