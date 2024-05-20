extends Node2D

onready var start = get_node("Botoẽs/iniciar")
onready var out = get_node("Botoẽs/fechar")
onready var tutorial_button = get_node("Botoẽs/tutorial")
onready var trasition: AnimationPlayer = get_node("Transition/AnimationPlayer")

func _ready() -> void:
	$upDownInfo/down.rect_scale = $upDownInfo/down.rect_scale.move_toward(Vector2(1.0, 1.0), 0.05)
	$upDownInfo/up.rect_scale = $upDownInfo/up.rect_scale.move_toward(Vector2(1.0, 1.0), 0.05)
	
	$Transition.connect("acabou",self,"tras")
	trasition.play("fade_in")
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
func tras():
	$Transition.layer = -1

func _on_fechar_pressed() -> void:
	 get_tree().quit()


func _on_iniciar_pressed() -> void:
	get_tree().change_scene("res://Cenas/Information.tscn")


func _on_tutorial_pressed() -> void:
	get_tree().change_scene("res://Cenas/Tutorial.tscn")
