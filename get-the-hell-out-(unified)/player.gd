extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $twistPivot
@onready var pitch_pivot := $twistPivot/pitchPivot
@onready var agent = $NavigationAgent3D


# Called when the node enters the scene tree for the first time.


func _ready():
	targ = Vector3(10,0,10)
	updateTargetLocation(targ)


func _physics_process(delta):
	look_at(targ)
	rotation.x = 0
	rotation.z = 0


	if position.distance_to(targ) > 0.5:
		var curLoc = global_transform.origin
		var nextLoc = agent.get_next_path_position()
		var newVel = (nextLoc - curLoc).normalized() * SPEED


func updateTargetLocation(target):
	agent.set_target_position(target)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")
	
	apply_central_force(twist_pivot.basis *  input * 1200.0* delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
