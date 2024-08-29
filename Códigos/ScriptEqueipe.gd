extends Node2D

enum  dev_iten {SHOW, HIDEN}

func _ready():
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
	interactWithDevItens(0, $Labels )
	interactWithDevItens(1, $Draws)

func _on_out_pressed():
	global.getTransition(0, "menu")


func _on_linkRav_mouse_entered() -> void:
	$Labels/rav.percent_visible += 0.005;

func _on_linkAni_mouse_entered() -> void:
	$Labels/anni.percent_visible += 0.005;

func _on_linkSof_mouse_entered() -> void:
	$Labels/sof.percent_visible += 0.005;

func _on_linkSKAR_mouse_entered() -> void:
	$Labels/kactus.percent_visible += 0.005;


func HideAllDraw():
	for i in $Draws.get_children():
		i.self_modulate.a -= 0.005

func _on_pass_pressed():
	$apagador_move.play("RESET")
	HideAllDraw()
	
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
