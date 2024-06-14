extends Control

onready var _tempo = get_node("tempo_label")

func _ready() -> void:
	$aviso.percent_visible = 0
	global.playSound("countdown", 4.0)
	$Timer.start(4)

func _process(delta):
	$aviso.percent_visible += .02
	var _timeLeft: int = int($Timer.time_left);
	_tempo.text = str(_timeLeft)

func _on_Timer_timeout() -> void:
	global.getTransition(0, "quiz")
