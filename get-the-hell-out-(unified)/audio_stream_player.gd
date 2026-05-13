extends Node


@onready var menuStream = $mainMenu
@onready var level1Stream = $level1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

func menu_audio() -> void:
		menuStream.play()
	
func credits_audio() -> void:
	menuStream.get_stream_playback()


func Level_1_audio() -> void:
	level1Stream.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
