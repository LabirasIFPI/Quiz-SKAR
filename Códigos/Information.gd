extends Control

onready var _label_info = get_node("Label")

func _ready():
	global.getTransition(1)
# Direcionamento dos sinais
	WebSocket.connect("azul", self, "_on_up_pressed")
	WebSocket.connect("vermelho", self, "_on_down_pressed")
	
	WebSocket.connect("botaoA", self, "_on_pass_pressed")
	WebSocket.connect("botaoB", self, "_on_pass_pressed")
	WebSocket.connect("botaoC", self, "_on_pass_pressed")

func _process(_delta):
	if _label_info.percent_visible < 1:
		_label_info.percent_visible += .006;
	$upDownInfo/inf.text = str(global.maxPoints)
	

func _on_pass_pressed():
	global.getTransition(0,"contagem")

## Adiciona um valor à barra
func _on_up_pressed():
	print("add manoooooooo")
	if global.maxPoints < 20:
		global.maxPoints += 1;

## Retira um valor da barra
func _on_down_pressed():
	print("tira manooooooooo")
	if global.maxPoints > 5:
		global.maxPoints -= 1;
