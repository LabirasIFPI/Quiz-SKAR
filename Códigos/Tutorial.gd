extends Node2D


var controle = 0;

onready var _label_texto = get_node("Informação/informação")

var informacoes: Array = [
	"Primeiramente, ligue e reinicie a 'caixa de resposta' e entre na rede 'SKAR_Quiz'",
	"Agora configure com sua rede WIFI!",
	"Tudo pronto?! Agora vamos aprender como JOGAR!!!",
	"Este é um jogo para dois jogadores: o azul e o vermelho.     SE POSICIONEM!",
	"Responde a pergunta aquele que apertar primeiro o botão de sua respectiva cor. Cada pergunta tem seu tempo pra resposta, responda entes que o tempo acabe!",
	"Estes botões representam sua resposta, sendo eles 'A','B' e'C'. Cada resposta correta soma ponto(s), uma resposta errada ou vazia irá somar ponto(s) ao seu oponente.",
	"Vence aquele que somar mais pontos no final da rodada. Bom JOGO e bons ESTUDOS!!!<3"
]

func _ready():
	pass 

func _process(delta: float) -> void:

	print("contrlole: ",  controle)
	_label_texto.text = informacoes[controle]

func DefinirTextoPorPagina():
	var _operacao = 1 - 2 * global.jogadorAtual;#se esquerda(red): -1, se dir(azul): 1
	print(_operacao)
	if (_operacao > 0 and controle <= (informacoes.size() - 2)) or (_operacao < 0 and controle >= 1):
		controle += _operacao
		_label_texto.text = informacoes[controle]

func _on_avancar_esquerda_pressed() -> void:
	#Essa atribuição só existe a fim de testes. Ela representa o sinal recebido.
	global.jogadorAtual = 1
	DefinirTextoPorPagina()

func _on_sair_pressed() -> void:
	get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_avancar_direita_pressed() -> void:
	#Essa atribuição só existe a fim de testes. Ela representa o sinal recebido.
	global.jogadorAtual = 0
	DefinirTextoPorPagina()
