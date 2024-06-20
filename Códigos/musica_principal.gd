extends Node2D

onready var _song = get_node("musica_main")
onready var _clock = get_node("clock")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_song.play()
	
	## Começa musica principal
func stopSong():
	_song.stop()
	
	## Para musica principal
func returnSong():
	_song.play()
	
	## Começar som do relógio
func startClock():
	_clock.play()
	
	## Parar som do relógio
func stopClock():
	_clock.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
