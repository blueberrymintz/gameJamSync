extends Node3D

@onready var rotation_x = $CameraRotationX
@onready var zoom_pivot = $CameraRotationX/ZoomPositionPivot
@onready var camera =$CameraRotationX/ZoomPositionPivot/Camera3D

#Variables
var move_speed = 0.6
var move_target: Vector3
var wasd_lerp = 0.05
var rotate_speed = 1.5
var rotate_target: float
var zoom_speed = 1.0
var zoom_target: float
var zoom_min = -20
var zoom_max = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_target = position
	rotate_target = rotation_degrees.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var movement_direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	var rotate_input_direction = Input.get_axis("rotate_left", "rotate_right")
	var zoom_direction = Input.get_axis("zoom_in", "zoom_out")
	
	#move targets
	move_target += move_speed * movement_direction
	rotate_target += rotate_input_direction * rotate_speed
	zoom_target += zoom_direction * zoom_speed
	
	
	#lerp (linear interpolation)
	position = lerp(position, move_target, wasd_lerp)
	rotation_degrees.y = lerp(rotation_degrees.y, rotate_target, wasd_lerp)
	camera.position.z = lerp(camera.position.z, zoom_target, wasd_lerp)
	
