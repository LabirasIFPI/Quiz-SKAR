extends Control

onready var transition: AnimationPlayer = get_node("Transition/AnimationPlayer")
onready var _info_label: RichTextLabel = get_node("Midle/informação")
onready var timer = get_node("ToPass")

func _ready() -> void:
	$Transition.connect("acabou", self, "change_scene")
	_info_label.append_bbcode("[center]O jogo QUIZ é totalmente controlado pela 'caixa resposta'. Fique atento às [wave amp=100][color=#eb5050]cores[/color] [color=gray]dos[/color] [color=#1E90FF]botões")
	_info_label.percent_visible = 0
	
	timer.start(5)
	
func _process(delta):
	_info_label.percent_visible += .006
	

func _on_ToPass_timeout() -> void:
	transition.play("fade_out")
	
func change_scene():
	get_tree().change_scene("res://Cenas/Menu.tscn")
