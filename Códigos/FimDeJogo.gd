extends Node2D

onready var _lab_p1 = get_node("Menu/Janelas/p1")
onready var _lab_p2 = get_node("Menu/Janelas/p2")
onready var _confetti = get_node("effects/Particles2D")


func _ready() -> void:
	## Chama efeito de confete
	_confetti.emitting = 1
	audio.stopSong()
	_lab_p1.text = str(global.pontos[0])
	_lab_p2.text = str(global.pontos[1])
	global.playSound("won", 6.0)
	
	if winnerPoints():
		changeEfectColorByPlayer(global.jogadorAtual)
	else:
		changeEfectColorByPlayer(global.getOppositePlayer())


# Retorna pra tela inicial
func _on_Back_pressed() -> void:
	audio.returnSong()
	get_tree().change_scene("res://Cenas/Menu.tscn")

func changeEfectColorByPlayer(indPlayer):
	var _color: Array = [Color.dodgerblue, Color.red]
	_confetti.color = _color[indPlayer]
	
func winnerPoints() -> bool:
	return global.pontos[0] > global.pontos[1]
