extends Node
#Muda quando um botão de alternativa for pressionado
var resposta : = '';
#contagem de pontos do jogador 1 (azul)
var pontos_p1 : = 0;
#contagem de pontos do jogador 2 (vermelho)
var pontos_p2: = 0;
# Quando o jogadro 1(azul) apertou o botão primeiro ==>vez de resposta
var resp_p1: = false;
#Quando o jogadro dois(red) apertou o botã primeiro ==>vez de resposta
var resp_p2: = false;

func _ready():
	pass 
func _process(delta):
	print(resposta)
