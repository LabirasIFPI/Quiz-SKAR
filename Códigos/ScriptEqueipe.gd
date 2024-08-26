extends Node2D



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
	$Links/pass/LabirasLogo.scale.linear_interpolate(Vector2(0.8, 0.8), 0.150);
	teste(1, $Labels)
	teste(2, $devDraw)

func teste(funcao, father):
	
	match (funcao):
		1: 
			for devText in father.get_children():
				if devText.percent_visible != 0.0:
					devText.percent_visible += 0.005
					
		2:
			for devIten in father.get_children():
				if devIten.self_modulate.a !=1.0:
					devIten.self_modulate.a -= 0.010
			
			
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

#
func HideAllDrawns():
	$devDraw/Anni.self_modulate.a -= 0.005;
	$devDraw/Kacto.self_modulate.a -= 0.005;
	$devDraw/Rav.self_modulate.a -= 0.005
	$devDraw/Sofia.self_modulate.a -= 0.005;


func _on_pass_pressed():
	HideAllDrawns()
	$Labels.visible =0;
	$apagador_move.play("RESET")
	$Links/pass/LabirasLogo.scale = Vector2(1, 1)
