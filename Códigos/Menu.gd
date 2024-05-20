extends Node2D
signal azul
func _ready() -> void:
	## Recebimento e direcionamento dos sinais recebidos
	# Chamam as demais funçoes
	WebSocket.connect("azul", self, "_on_iniciar_pressed")
	WebSocket.connect("vermelho", self, "_on_fechar_pressed")
	# Executam o botao "tutorial"
	WebSocket.connect("botaoA", self, "_on_tutorial_pressed")
	WebSocket.connect("botaoB", self, "_on_tutorial_pressed")
	WebSocket.connect("botaoC", self, "_on_tutorial_pressed")
	
	# Toca musica principal do jogo
	audio.returnSong()

func _on_fechar_pressed() -> void:
	 get_tree().quit()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene("res://Cenas/Information.tscn")


func _on_tutorial_pressed() -> void:
	get_tree().change_scene("res://Cenas/Tutorial.tscn")
