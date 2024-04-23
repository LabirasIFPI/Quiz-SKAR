extends Node2D


var controle = 0;

onready var _label_texto = get_node("Informação/informação")

var informacoes: Array = [
	"tex1",
	"tet2",
	"text3"
]

func _ready():
	pass 

func _process(delta: float) -> void:
#	DefinirTextoPorPagina(controle)
	print("contrlole: ",  controle)
#	print("array: " , DefinirTextoPorPagkina(controle))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func DefinirTextoPorPagina(id):
	var _operacao = 1 - 2 * global.jogadorAtual;#se esquerda(red): -1, se dir(azul): 1
	if id <= (informacoes.size() - 1):
		_label_texto.text = informacoes[id]
		controle += _operacao
	else:
		controle = informacoes.size()

func _on_avancar_esquerda_pressed() -> void:
	controle -= 1
#	DefinirTextoPorPagina(controle)

func _on_sair_pressed() -> void:
	get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_avancar_direita_pressed() -> void:
	if controle <= (informacoes.size() - 2):
		controle += 1
	else:
		controle = informacoes.size()
#	_label_texto.text = informacoes[controle]
	_label_texto.text = informacoes[controle]
#	DefinirTextoPorPagina(controle)
