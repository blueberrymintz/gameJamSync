extends CharacterBody3D

#use updateTargetLoc to set target location

@export var overlayScene: PackedScene
@onready var agent = $NavigationAgent3D
var speed = 1
var target: Vector3
var nextLoc: Vector3
var snappedNextLoc: Vector3
var mapPath: PackedVector3Array

var movement_speed: float = 4.0
var movement_delta: float
var path_point_margin: float = 0.5

var current_path_index: int = 0
var current_path_point: Vector3
var current_path: PackedVector3Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#target = Vector3(randf_range(-45, 45), 0, randf_range(-45, 45))
	#updateTargetLoc(target)
	chooseRandomTarget()
	updateTargetLoc(target)

func set_movement_target(target_position: Vector3):

	var start_position: Vector3 = global_transform.origin

	current_path = NavigationServer3D.map_get_path(
		agent.get_navigation_map(),
		start_position,
		target_position,
		false
	)

	if not current_path.is_empty():
		current_path_index = 0
		current_path_point = current_path[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#check for 0, 0, 0 because the game has to tick at least once before the navmesh is online
	if target == Vector3(0, 0, 0):
		chooseRandomTarget()
	
	#if position.distance_to(target) > 0.5:
		#mapPath = NavigationServer3D.map_get_path(agent.get_navigation_map(), global_transform.origin, target, false, 1)
		#var curLoc = global_transform.origin
		#nextLoc =  agent.get_next_path_position()
		#snappedNextLoc = snapToGrid(nextLoc)
		#var newVal = (nextLoc - curLoc).normalized() * speed
		#velocity = newVal
		#move_and_slide()
		
		
	#look_at(nextLoc)
	rotation.x = 0
	rotation.z = 0
	
	if current_path.is_empty():
		return
	
	movement_delta = movement_speed * delta

	if global_transform.origin.distance_to(current_path_point) <= path_point_margin:
		current_path_index += 1
		if current_path_index >= current_path.size():
			current_path = []
			current_path_index = 0
			current_path_point = global_transform.origin
			return

	current_path_point = current_path[current_path_index]

	var new_velocity: Vector3 = global_transform.origin.direction_to(current_path_point) * movement_delta

	global_transform.origin = global_transform.origin.move_toward(global_transform.origin + new_velocity, movement_delta)

	
	if position.distance_to(target) <= 1:
		chooseRandomTarget()
		
func chooseRandomTarget():
		#target = snapToGrid(Vector3(NavigationServer3D.map_get_random_point(agent.get_navigation_map(), 1, true)))
		target = Vector3(NavigationServer3D.map_get_random_point(agent.get_navigation_map(), 1, true))
		updateTargetLoc(target)
		
func snapToGrid(vector):
	var newVector = Vector3(2*floor(vector.x/2)+1, vector.y, 2*floor(vector.z/2)+1)
	return newVector

func updateTargetLoc(target):
	agent.set_target_position(target)
	set_movement_target(target)

const RAY_LENGTH = 1000.0

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = get_viewport().get_camera_3d()
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.new()
		var instance
		
		params.from = from
		params.to = to
		params.collide_with_areas = true  # Set to true to include Area nodes
		params.collide_with_bodies = true
		
		var result = space_state.intersect_ray(params)
		print("test")
		if result.is_empty():
			print("empty result")
		elif result and result.collider and result.collider.is_class("Area3D"):
			result.collider.on_ray_hit()
		else: 
			print("Raycast hit:", result.collider.name)
			if result.collider.name == "Floor":
				print(result.position)
				updateTargetLoc(Vector3(result.position.x, 2.5, result.position.z))
				instance = overlayScene.instantiate()
				instance.transform.origin = Vector3(result.position.x, 4.5, result.position.z)
				
