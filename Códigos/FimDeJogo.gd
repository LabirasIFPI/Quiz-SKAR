extends Node2D

onready var _lab_p1 = get_node("Menu/p1")
onready var _lab_p2 = get_node("Menu/p2")
onready var _confetti = get_node("effects/Particles2D")
onready var _shader = get_node("Back/shader")

var players: Array = ["[color=#1E90FF]Azul", "[color=red]Vermelho"]

func _ready() -> void:
	global.getTransition(1)
#	_shader.visible = false
	
	# Direcionamento dos sinais
	WebSocket.connect("vermelho", self, "_on_Back_pressed")

	## Chama efeito de partícula para cor do vencedor
	_confetti.emitting = 1
	changeColorEfectByPlayer(winner())
	
	audio.stopSong()
	_lab_p1.text = str(global.pontos[0])
	_lab_p2.text = str(global.pontos[1])
	global.playSound("won", 6.0)
	informWinner()


# Retorna pra tela inicial
func _on_Back_pressed() -> void:
	global.getTransition(0, "menu")
	global.maxPoints = 5
	setPoints()
	audio.returnSong()
	
## Printa na tela o vencedor
func informWinner():
#MAYBE
	var _labelInform = get_node("Menu/winner")
	_labelInform.append_bbcode("[center]Parabéns jogador " + players[winner()] + "!")#mudar frase

## Muda a cor das partículas para cada jogador
func changeColorEfectByPlayer(indPlayer):
	var _color: Array = [Color.dodgerblue, Color.red]
	_confetti.color = _color[indPlayer]
	
## Retorna o jogador vencedor (0 para azul; 1 para vermelho)
func winner() -> int:
	var higher_value = global.pontos[0]
	var higher_ind = 0
	for i in range(global.pontos.size()):
		if global.pontos[i] > higher_value:
			higher_ind = i
	return higher_ind 


## Zera a pontuação dos jogadores
func setPoints():
	for i in range(global.pontos.size()):
		global.pontos[i] = 0
