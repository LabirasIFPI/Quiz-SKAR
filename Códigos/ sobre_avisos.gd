extends Control

onready var _tempo = get_node("tempo_label")



func _ready() -> void:
	$Transition.connect("acabou",self,"sair")
	$aviso.percent_visible = 0
	global.playSound("countdown", 4.0)
	$Timer.start(4)

func _process(delta):
	$aviso.percent_visible += .02
	_tempo.text = str(int($Timer.time_left))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://Cenas/QuizMain.tscn")
