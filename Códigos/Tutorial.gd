extends Node2D

var controle = 0;
onready var imagesNode: Control = get_node("PassosImagem");

onready var _label_texto = get_node("Informação/informação")

var informacoes: Array = [
	"1 Primeiramente, ligue e reinicie a 'caixa de resposta' e entre na rede 'Rede_SKAR'",
	"2 Agora configure com sua rede WIFI!",
	"3 Agora sua rede está salva!",
	"4 Tudo pronto?! Agora vamos aprender como JOGAR!!!",
	"5 Este é um jogo para dois jogadores: o azul e o vermelho.     SE POSICIONEM!",
	"6 Responde a pergunta aquele que apertar primeiro o botão de sua respectiva cor. Cada pergunta tem seu tempo pra resposta, responda antes que o tempo acabe!",
	"7 Estes botões representam sua resposta, sendo eles 'A','B' e'C'. Cada resposta correta soma ponto(s), uma resposta errada ou vazia irá somar ponto(s) ao seu oponente.",
	"8 Vence aquele que somar mais pontos no final da rodada. Bom JOGO e bons ESTUDOS!!!<3"
]

onready var images: Array = [
	imagesNode.get_node("caixa_onoff"),
	imagesNode.get_node("Fundo1"),
	imagesNode.get_node("Passo3"),
	imagesNode.get_node("Pessoas1"),
	imagesNode.get_node("PessoaLuta"),
	imagesNode.get_node("Caixa1"),
	imagesNode.get_node("Caixa2"),
	imagesNode.get_node("Pessoas2")
]

func _ready():
	# Direcionamento dos sinais
	WebSocket.connect("azul", self, "_on_avancar_direita_pressed")
	WebSocket.connect("vermelho", self, "_on_avancar_esquerda_pressed")
	WebSocket.connect("botaoA", self, "_on_sair_pressed")
	WebSocket.connect("botaoB", self, "_on_sair_pressed")
	WebSocket.connect("botaoC", self, "_on_sair_pressed")
	
	_label_texto.percent_visible = 0;
	updateScreen();
	

## Atualiza o texto e exibe a imagem correspondente
func updateScreen():
	# Atualizar texto exibido
	_label_texto.text = informacoes[controle]

	# Atualizar imagem
	for node in imagesNode.get_children():
		node.visible = node == images[controle]


func _process(delta: float) -> void:
	_label_texto.percent_visible += .02
		

func DefinirTextoPorPagina():
	var _operacao = (1 - 2 * global.jogadorAtual) ;#se esq(red): -1, se dir(azul): 1
	print("Jogador atual: " + str(global.jogadorAtual))
	print("Resultado da op: " + str(_operacao))
	if (_operacao > 0 and controle <= (informacoes.size() - 2)) or (_operacao < 0 and controle >= 1):
		controle += _operacao
		updateScreen()
		_label_texto.percent_visible = 0;

func _on_avancar_esquerda_pressed() -> void:
	DefinirTextoPorPagina()

func _on_sair_pressed() -> void:
	get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_avancar_direita_pressed() -> void:
	DefinirTextoPorPagina()
