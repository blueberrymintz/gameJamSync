extends Node3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.queue("idle_animation")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_animation_player_current_animation_changed(animationName: StringName) -> void:
	$AnimationPlayer.queue("idle_animation") # Replace with function body.
