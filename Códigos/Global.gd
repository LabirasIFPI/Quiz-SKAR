extends Node

#Sobre WI-FI
var txt = "";
var client;
var connected: bool = false;

## IP da rede acessada (lembrar: era const)
const ip = "192.168.17.212";
const port = 80;

## Inicializar signals
signal botaoAzul(Tutorial, QuizMain);
signal botaoVermelho(Tutorial, QuizMain);

## Scene de sons
onready var soundNode = preload("res://Cenas/SoundNode.tscn");

## Guarda valor da resposta inserido pelo usuário.
var resposta: int = -1;

## Pontuação dos jogadores:
# pontos[0] --- pontuação do jogador 1
# pontos[1] --- pontuação do jogador 2
var pontos: Array = [0, 0];

## Pontuação necessária para vencer a partida.
var maxPoints = 5;

# Armazena o indice do jogador da vez, que irá responder. 
# -1 = ninguem, 0 = azul, 1 = vermelho
var jogadorAtual = -1;


## Dicionário que carrega estado das teclas pressionadas
var keys: Dictionary = {
	'B1': false,
	'B2': false
}

# Direçoes para sons do jogo
var sounds: Dictionary = {
	"right": preload("res://Musicas/Correta.wav"),
	"wrong": preload("res://Musicas/Errada.wav"),
	"bell": preload("res://Musicas/Sino.wav"),
	"won": preload("res://Musicas/Vitoria.wav"),
	"countdown": preload("res://Musicas/arcade-countdown-7007.wav")
}

func _ready():
	client = StreamPeerTCP.new()
	client.connect_to_host(ip, port)
	if(client.is_connected_to_host()):
		connected = true
		print("Conectado")
		
func _process(delta):
	# Redefinir botões para false.
	redefineButtons();
	
	# Saber se está conectado com o Esp32
	if connected and not client.is_connected_to_host():
		connected = false
	else:
		# Se estiver conectado
		_readWebSocket()

## Lê mensagens enquanto estiver conectado
func _readWebSocket():
	while client.get_available_bytes()>0:
		var message = client.get_utf8_string(client.get_available_bytes())
		# Evitar bugs e mensagens vazias
		if message == null:
			continue
			# Recebe as mensagens e manda interpretar
		elif message.length() > 0:
			print(message)
			for i in message:
				if i =='\n':
					# Mensagem recebida por completo.
					_messageInterpreter(txt)
					txt = "";
				else:
					txt += i

# Na prática: aqui txt ainda não é o a mesnsagem recebida pelo Esp32(ainda null)
# Erro: Não há como mudar o ip se não há como receber o novo ip sem um ip
# Solução: tornar, inicialmente, a rede IFPI_ALUNOS como ip daqui
func change_ip():
	pass
#	var command = txt.split(' ')
#	if command.size() == 2:
#		print("sou grandee")
#		##Pra trocar o ip pelo ip recebido
#		if command[0] == "ip":
#			ip = command[1]

func _writeWebsocket(txt):
	if connected and client.is_connected_to_host():
		client.put_data(txt.to_ascii())
				
## Interpreta a mensagem de acordo com a vontade do programador
func _messageInterpreter(txt):
	print("Interpretando mensagem: %s" % [txt]);
	# A mensagem tem formato: "LALALA B1"
	var command = txt.split(' ');
	
	if command[1] == "B1":
		print("grande um")
	# command[0] -> Identificador da pessoa
	# command[1] -> Botão apertado
	if command.size() == 2:
		if command[1] == "B1":
			keys.B1 = true;
			emit_signal("botaoAzul");
		if command[1] == "B2":
			keys.B2 = true;
			emit_signal("botaoVermelho");
		
		# O ideal seria ser assim:
#		keys[command[1]] = true;

## Define o jogador da vez para o indice desejado
func definirJogadorAtual(ind):
	if global.jogadorAtual == -1: 
		global.jogadorAtual = ind;

## Avalia se há algum jogador na vez
func temJogadorNaVez():
	return global.jogadorAtual != -1;

func redefineButtons() -> void:
	keys.B1 = false;
	keys.B2 = false;

func getButtonPressed(_buttonKey: String) -> bool:
	##Torna a mensaguem maiúcula, por mais que não seja necessário
	var key = _buttonKey.to_upper();
	return keys[key];

## Instancia um soundNode para tocar um som específico.
func playSound(sound, duration = 5.0):
	var _snd = soundNode.instance();
	var _soundToPlay = sounds.get(sound);
	_snd.soundToPlay = _soundToPlay;
	_snd.timeToDestroy = duration;
	add_child(_snd);

func getOppositePlayer(arg) -> int:
	var _sinal = 1 - 2 * arg # se vermelho: -1, se azul: 1
	return arg + 1  * _sinal;
