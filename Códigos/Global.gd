extends Node
#Muda quando um botão de alternativa for pressionado
var resposta : = -1;
#contagem de pontos do jogador 1 (azul)
var pontos_p1 : = 0;
#contagem de pontos do jogador 2 (vermelho)
var pontos_p2: = 0;

# pontos[0] --- pontuação do jogador 1
# pontos[1] --- pontuação do jogador 2
var pontos: Array = [0, 0];

# Armazena o indice do jogador da vez. -1 = ninguem, 0 = azul, 1 = vermelho
var jogadorAtual = -1;


# Quando o jogadro 1(azul) apertou o botão primeiro ==>vez de resposta
#var resp_p1: = false;
#Quando o jogadro dois(red) apertou o botã primeiro ==>vez de resposta
#var resp_p2: = false;

func _ready():
	pass 
func _process(delta):
	pass
#	print(resposta)

## Define o jogador da vez para o indice desejado
func definirJogadorAtual(ind):
	if global.jogadorAtual == -1: 
		global.jogadorAtual = ind;

## Avalia se há algum jogador na vez
func temJogadorNaVez():
	return global.jogadorAtual != -1;
