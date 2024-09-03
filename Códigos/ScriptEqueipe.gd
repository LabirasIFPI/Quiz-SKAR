extends Node2D

enum  dev_iten {SHOW, HIDEN}

# Configurações da tremida
var shake_amount = 2.0  
var shake_speed = 50.0    
var shake_duration = 0.4 

# Variáveis de controle
var is_shaking = false
var shaking_timer = 0.0
var original_position = []


func _ready():
	$TimerPisca.start(0.2)
	# Armazena a posição original do sprite
	for i in $Draws.get_children():
		original_position.append(i.position)

	global.getTransition(1)
	WebSocket.connect("botaoA", self,"_on_out_pressed")
	WebSocket.connect("botaoB", self,"_on_out_pressed")
	WebSocket.connect("botaoC", self,"_on_out_pressed")
	WebSocket.connect("azul", self, "FindAllTexts")
	$Labels/rav.bbcode_text = "[b]Ravena: [/b] A mente criativa por tras do Quiz. Ela programou e deu vida ao jogo, alem de ser a artista responsável de cada arte do jogo, tornando-o visualmente deslumbrante!"
	$Labels/anni.bbcode_text = "[b]Anísia: [/b] Trouxe o Quiz para o mundo real. Ela criou o circuito impresso essencial para o jogo e implementou a comunicação wifi, conectando o mundo fisico ao digital de forma brilhante!"
	$Labels/sof.bbcode_text = "[b]Sofia: [/b] Nao so programou os botoes que tornam possivel sua jogabilidade, como tambem contribuiu para a comunicacao wifi entre o circuito e o jogo, garantindo sua experiencia interativa e imersiva!"
	$Labels/kactus.bbcode_text = "[b]Kactus: [/b] O mascote da equipe SKAR ;M"


func _process(delta):
	interactWithDevItens(dev_iten.SHOW, $Labels )
	interactWithDevItens(dev_iten.HIDEN, $Draws)
	interactWithDevItens(dev_iten.HIDEN, $Labels)

#sai da tela 
func _on_out_pressed():
	global.getTransition(0, "menu")

#Para todos os 'mouse_entred' a seguir: Serve como gatilho para inicar os texto e a tremida
func _on_linkRav_mouse_entered() -> void:
	$Labels/rav.percent_visible += 0.005;
	#Analisa se a tremidinha já passou
	if not is_shaking:
		start_shaking($Draws/Rav, 3)


func _on_linkAni_mouse_entered() -> void:
	$Labels/anni.percent_visible += 0.005;
	if not is_shaking:
		start_shaking($Draws/Anni, 1)


func _on_linkSof_mouse_entered() -> void:
	$Labels/sof.percent_visible += 0.005;
	if not is_shaking:
		start_shaking($Draws/Sofia, 4)


func _on_linkSKAR_mouse_entered() -> void:
	$Labels/kactus.percent_visible += 0.005;
	if not is_shaking:
		start_shaking($Draws/Kacto, 2)


# Esconde todos os desenhos de dev
func HideAllDraw():
	for i in $Draws.get_children():
		i.self_modulate.a -= 0.005

func HideAllLabels():
	for i in $Labels.get_children():
		i.self_modulate.a -= 0.005

		
func _on_pass_pressed():
	$Animations/apagador_move.play("RESET")
	HideAllDraw()
	HideAllLabels()
	yield(get_tree().create_timer(0.8), "timeout")
	EasterEgg()
	
	# Para alterar o alpha e visibilidade dos nodes relacionados aos devs
func interactWithDevItens(function, father):
	match(function):
		0:
			for devText in father.get_children():
				if devText.percent_visible !=0:
					devText.percent_visible += 0.005
		
		1:
			for devDraw in father.get_children():
				if devDraw.self_modulate.a != 1:
					devDraw.self_modulate.a -= 0.010


func EasterEgg():
	pass



#Chama a tremida para o Sprite indicado
func start_shaking(dev, number):
	is_shaking = true
	shaking_timer = shake_duration
	_shake(dev, number)


#Treme a sprite
#Obs: number é o numero que indica a posição da sprite em uma Array.Busco maneiras de aprimorar isso
func _shake(sprite, number):
	if shaking_timer > 0:
		# Calcula o deslocamento de sacudida usando uma função seno(obg, chat)
		var shake_timer = (shake_duration - shaking_timer) * shake_speed
		var shake_offset = sin(shake_timer) * shake_amount
		# O resultado do calculo é aplicado na posição da sprite
		sprite.position.x = original_position[number].x + shake_offset

		shaking_timer -= get_process_delta_time()
		# 'Loop' improvisado => para repetir a função enquato há tempo restando
		yield(get_tree().create_timer(0.02), "timeout")
		_shake(sprite, number)
	else:
		# Reseta a posição do sprite depois do tremor pra posição original
		sprite.position = original_position[number]
		is_shaking = false


func _on_TimerPisca_timeout():
	$Animations/shadow.play("pisca")
	$TimerPisca.start(5.0)
