extends Node2D

onready var song = get_node("musica_main")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	song.play()
	
	
func _process(delta: float) -> void:
	pass
	
func stopSong():
	song.stop()
func returnSong():
	song.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
