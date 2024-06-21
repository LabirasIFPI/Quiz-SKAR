extends Node2D

var controle = 0;
onready var imagesNode: Control = get_node("PassosImagem");

onready var _label_texto = get_node("Informação/informação")

var value = -1

var informacoes: Array = [
	"Primeiramente, ligue e reinicie a 'caixa de resposta' e entre na rede 'Rede_SKAR'",
	"Agora configure com sua rede WIFI!",
	"Agora sua rede está salva!",
	"Tudo pronto?! Agora vamos aprender como JOGAR!!!",
	"Este é um jogo para dois jogadores: o azul e o vermelho.\nSE POSICIONEM!",
	"Responde a pergunta aquele que apertar primeiro o botão de sua respectiva cor. Cada pergunta tem seu tempo pra resposta, responda antes que o tempo acabe!",
	"Estes botões representam sua resposta, sendo eles 'A','B' e'C'. Cada resposta correta soma ponto(s), uma resposta errada ou vazia irá somar ponto(s) ao seu oponente.",
	"Vence aquele que somar mais pontos no final da rodada. Bom JOGO e bons ESTUDOS!!!<3"
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
	global.getTransition(1)
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
	#@TODO: isso esta dandoerros. entender: jogador atual´re 1 e consertar
	# Atualizar texto exibido
	_label_texto.bbcode_text = "[center]" + informacoes[controle]

	# Atualizar imagem
	for node in imagesNode.get_children():
		node.visible = node == images[controle]


func _process(_delta: float) -> void:
	_label_texto.percent_visible += .02
	if Input.is_action_just_pressed("ui_down"):
		global.getTransition(0,"menu")
		

func DefinirTextoPorPagina():
	print("Jogador atual: " + str(global.jogadorAtual))
	var _operacao = 1 - (2 * value) ;#se esq(red): -1, se dir(azul): 1
	print("Resultado da op: " + str(_operacao))
	if (_operacao > 0 and controle <= (informacoes.size() - 2)) or (_operacao < 0 and controle >= 1):
		controle += _operacao
		updateScreen()
		_label_texto.percent_visible = 0;

func _on_avancar_esquerda_pressed() -> void:
	value = 1
	DefinirTextoPorPagina()

func _on_sair_pressed() -> void:
	global.getTransition(0,"menu")


func _on_avancar_direita_pressed() -> void:
	value = 0
	DefinirTextoPorPagina()
