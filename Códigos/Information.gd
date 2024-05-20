extends Control

onready var _label_info = get_node("CanvasLayer/Label")

func _ready():
# Direcionamento dos sinais
	WebSocket.connect("azul", self, "_on_up_pressed")
	WebSocket.connect("vermelho", self, "_on_down_pressed")
	WebSocket.connect("botaoA", self, "_on_pass_pressed")
	WebSocket.connect("botaoB", self, "_on_pass_pressed")
	WebSocket.connect("botaoC", self, "_on_pass_pressed")

func _process(delta):
	if _label_info.percent_visible < 1:
		_label_info.percent_visible += .006;
	$upDownInfo/inf.text = str(global.maxPoints)
	
	$upDownInfo/down.rect_scale = $upDownInfo/down.rect_scale.move_toward(Vector2(1.0, 1.0), 0.05)
	$upDownInfo/up.rect_scale = $upDownInfo/up.rect_scale.move_toward(Vector2(1.0, 1.0), 0.05)
	

func _on_pass_pressed():
	get_tree().change_scene("res://Cenas/Aviso.tscn")

## Adiciona um valor à barra
func _on_up_pressed():
	$upDownInfo/up.rect_scale.x = rand_range(0.75, 0.90);
	$upDownInfo/up.rect_scale.y = rand_range(0.75, 0.90);
	if global.maxPoints < 20:
		global.maxPoints += 1;

## Retira um valor da barra
func _on_down_pressed():
	$upDownInfo/down.rect_scale.x = rand_range(0.75, 0.90);
	$upDownInfo/down.rect_scale.y = rand_range(0.75, 0.90);
	if global.maxPoints > 5:
		global.maxPoints -= 1;
