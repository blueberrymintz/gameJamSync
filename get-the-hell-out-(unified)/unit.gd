extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var selected : bool = false

#unit attributes
@export var baseMaxHealth : int
@export var baseDamage : int
@export var baseMovement : int = 0
var maxHealth : int = 1
var currentHealth : int = 1
var damage : int = 1
var movement : int = 1
var currentMovement : int = 1
var type = "unit"

var startPos

func select():
	selected = true
	
func clearSelect():
	selected = false

func initTurn():
	startPos = position
	currentMovement = movement

func _ready() -> void:
	maxHealth = baseMaxHealth
	currentHealth = maxHealth
	damage = baseDamage
	movement = baseMovement
	initTurn()
	
func toggleSelect() -> void:
	if selected:
		selected = false
	if !selected:
		selected = true
		
func boolSelect(choice: bool) -> void:
	if choice:
		selected = true
	if !choice:
		selected = false
	
	
func _process(delta: float) -> void:
	if selected:
		$selectionCircle.show()
	else:
		$selectionCircle.hide()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
