extends Control

const mainMenu = preload("res://start_menu.tscn")

#names

#music
#vanessa merlis

#producer and writer
#mason leibel

#programming
#guthrie demetrios
#liliana martin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_credits_pressed() -> void:
	print("menu pressed!")
	#for some reason calling this one has to be a change scene to file instead of the const and loading
	get_tree().change_scene_to_file("res://start_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
