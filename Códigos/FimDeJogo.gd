extends Node2D

onready var _lab_p1 = get_node("Menu/Janelas/p1")
onready var _lab_p2 = get_node("Menu/Janelas/p2")



func _ready() -> void:
	audio.stopSong()
	_lab_p1.text = str(global.pontos[0])
	_lab_p2.text = str(global.pontos[1])
	global.playSound("won", 6.0)



func _on_Back_pressed() -> void:
	audio.returnSong()
	get_tree().change_scene("res://Cenas/Menu.tscn")
