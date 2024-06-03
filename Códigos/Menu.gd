extends Node2D

onready var start = get_node("Botoes/iniciar")
onready var out = get_node("Botoes/fechar")
onready var tutorial_button = get_node("Botoes/tutorial")

func _ready() -> void:
	global.getTransition(1)
#	$Transition.connect("acabou",self,"tras")
	
	
	## Recebimento e direcionamento dos sinais recebidos
	# Chamam as demais funçoes
	WebSocket.connect("azul", self, "_on_iniciar_pressed")
	WebSocket.connect("vermelho", self, "_on_fechar_pressed")
	# Executam o botao "tutorial"
	WebSocket.connect("botaoA", self, "_on_tutorial_pressed")
	WebSocket.connect("botaoB", self, "_on_tutorial_pressed")
	WebSocket.connect("botaoC", self, "_on_tutorial_pressed")
	
	# Toca musica principal do jogo
#	audio.returnSong()
func _process(delta):
# Set escala dos botoes
	start.rect_scale = start.rect_scale.move_toward(Vector2(1.0, 1.0), 0.05)
	tutorial_button.rect_scale = tutorial_button.rect_scale.move_toward(Vector2(1.0, 1.0), 0.05)



func _on_iniciar_pressed() -> void:
	start.rect_scale = Vector2(rand_range(0.75, 0.9), rand_range(0.75, 0.9));
	get_tree().change_scene("res://Cenas/Information.tscn")


func _on_tutorial_pressed() -> void:
	tutorial_button.rect_scale.x= rand_range(0.5, 0.8)
	tutorial_button.rect_scale.y= rand_range(0.5, 0.8)
	get_tree().change_scene("res://Cenas/Tutorial.tscn")
