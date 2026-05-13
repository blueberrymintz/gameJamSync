extends Control

@onready var audio = $audio_manager


const MainMenu = preload("res://start_menu.tscn")
const Level1 = preload("res://navtest.tscn")
const LevelCredits = preload("res://credits.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_play_pressed() -> void:
	print("start pressed!")
	get_tree().change_scene_to_packed(Level1)
	
func _on_button_credits_pressed() -> void:
	print("credits pressed!")
	get_tree().change_scene_to_packed(LevelCredits)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
