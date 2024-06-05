extends Control

onready var _info_label: RichTextLabel = get_node("Midle/informação")
onready var timer = get_node("ToPlay")
onready var timer_pass = get_node("ToPass")


func _ready() -> void:
	_info_label.append_bbcode("[center]O jogo QUIZ é totalmente controlado pela 'caixa resposta'. Fique atento às [wave amp=100][color=#eb5050]cores[/color] [color=gray]dos[/color] [color=#1E90FF]botões")
	_info_label.percent_visible = 0
	
	timer.start(5.6)
	
func _process(delta):
	_info_label.percent_visible += .006


func _on_ToPlay_timeout() -> void:
	global.getTransition(0, "menu");
