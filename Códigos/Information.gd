extends Control

onready var _label_info = get_node("CanvasLayer/Label")

func _ready():
	pass

func _process(delta):
	if _label_info.percent_visible < 1:
		_label_info.percent_visible += .006;
	$upDownInfo/inf.text = str(global.maxPoints)
	

func _on_pass_pressed():
	get_tree().change_scene("res://Cenas/Aviso.tscn")

## Adiciona um valor à barra
func _on_up_pressed():
	if global.maxPoints < 20:
		global.maxPoints += 1;

## Retira um valor da barra
func _on_down_pressed():
	if global.maxPoints > 5:
		global.maxPoints -= 1;
