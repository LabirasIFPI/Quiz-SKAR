extends Control

onready var value_bar = get_node("HScrollBar")

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		addQuestionCount()
		
	global.maxPoints = value_bar.value

func _on_pass_pressed():
	if value_bar.value > 0:
		get_tree().change_scene("res://Cenas/Aviso.tscn")

## Adiciona um valor à barra
func addQuestionCount():
	value_bar.value += 1;
