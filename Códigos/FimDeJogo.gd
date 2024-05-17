extends Node2D

onready var _lab_p1 = get_node("Menu/Janelas/p1")
onready var _lab_p2 = get_node("Menu/Janelas/p2")
onready var _confetti = get_node("effects/Particles2D")

func _ready() -> void:
	#@TODO printat o vencedor na tela
	print(winner())
	## Chama efeito de partícula para cor do vencedor
	_confetti.emitting = 1
	changeColorEfectByPlayer(winner())
	
	audio.stopSong()
	_lab_p1.text = str(global.pontos[0])
	_lab_p2.text = str(global.pontos[1])
	global.playSound("won", 6.0)
	

# Retorna pra tela inicial
func _on_Back_pressed() -> void:
	setPoints()
	audio.returnSong()
	get_tree().change_scene("res://Cenas/Menu.tscn")


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
