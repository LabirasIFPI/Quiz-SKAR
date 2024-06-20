extends Node2D

onready var start = get_node("Botoes/iniciar")
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
func _process(_delta) -> void:
	yield(get_tree().create_timer(.52), "timeout")
	$Titulo.percent_visible += 0.0098


func _on_tutorial_pressed() -> void:
	global.getTransition(0, "tutorial");


func _on_iniciar_pressed():
	global.getTransition(0, "information");


func _on_equipe_pressed():
	global.getTransition(0, "equipe")
