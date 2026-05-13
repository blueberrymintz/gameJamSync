extends Node3D

@onready var audio = $audio_manager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.Level_1_audio()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
