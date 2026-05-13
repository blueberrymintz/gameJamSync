extends Control

const level1 = preload("res://navtest.tscn")
const levelCredits = preload("res:///credits.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_play_pressed() -> void:
	print("start pressed!")
	get_tree().change_scene_to_packed(level1)
	
func _on_button_credits_pressed() -> void:
	print("credits pressed!")
	get_tree().change_scene_to_packed(levelCredits)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
