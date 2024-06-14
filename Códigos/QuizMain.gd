extends Node2D
# INFORMAÇÃO: TLPR significa tempo limite por pergunat
# @TODO mostrar a resposta correta
## Dados do Json  aqui (questio, id and options)
var questions = get_questionsData()

# originalmete de Atualzar Exibição (_opt é a cena alternativa instaciada)
var _opt

# var para barrar quem quer entrar na vez de outro
var controle = true

onready var correctNode = get_node("DoTeste")
onready var _questionLabel = get_node("Perguntas/PerguntasLabel");
onready var _label_aviso = get_node("CanvasLayer2/aviso") as Label
## Dicionario de pergunta atualmente sendo exibido.
var perguntaExibida: Dictionary = {};

## Array de perguntas já exibidas.
var displayedQuestionIds: Array = [];


## Para fins de testes, essa variável irá armazenar o conteúdo dentro da pasta.json
var questions_data: Array = []


#Cena de alternativas
onready var optionsNode = get_node("Options");
onready var _points_p1 = get_node("CanvasLayer/pontos_p1")
onready var _points_p2 = get_node("CanvasLayer/pontos_p2")

## Cena da alternativa
onready var optionScene: PackedScene = preload("res://Cenas/alternativa.tscn");
## Cena Teste da cetinha

var colorProgress: float = 0.0;

enum TIPOS_DE_AVISO {ERRO, ACERTO, TEMPO_ESGOTADO}

## Obter índice do jogador oposto ao global.jogadorAtual.
func obterJogadorOposto() -> int:
	var _sinal = 1 - 2 * global.jogadorAtual; # se vermelho: -1, se azul: 1
	return global.jogadorAtual + 1  * _sinal;
	
	# @TODO verificar
func getRandomQuestion() -> Dictionary:
	if len(displayedQuestionIds) >= len(questions):
		print("[AVISO]: Acabou o banco de perguntas. Resetando perguntas exibidas.")
		displayedQuestionIds = []
		
	var _randQuestionInd = randi() % len(questions);
	var pergunta = questions[_randQuestionInd];
	
	var loops = 0
	#displayedQuestion está armazenando o id da primeira pergunta escolhida no range somente
	while displayedQuestionIds.has(questions[_randQuestionInd].id):
		_randQuestionInd = randi() % len(questions);
		loops += 1
		print("embaralhando")
	
	pergunta = questions[_randQuestionInd];	
	return pergunta;

func _ready() -> void:
	global.getTransition(1)
	# Direciona os sinais > saber que alguem apertou
	WebSocket.connect("azul", self, "blueIn")
	WebSocket.connect("vermelho", self, "redIn")
	
	# Muda o "modo" de atuação do esp32 para "modo QUIZ"	
	WebSocket._writeWebsocket("MUDAR\n")
	
	# Temporariamente vamos deixar esse código aqui para pedir ajuda pra Godot
	var saveFile = JSON.to_string()
	
	randomize()
	##Retorna a variavel ao valor original(pois também é usada no "tutorial" pra um só dinal n mexer em duas var)
	global.jogadorAtual = -1
	# Define qual pergunta será exibida
	perguntaExibida = getRandomQuestion()
	displayedQuestionIds.append(perguntaExibida.id)
	
	# Atualiza a exibição
	atualizarExibicao();
#	print(getQuestionBy_id(3))

## Atualizar texto do tempo.
func updateTimeLabel() -> void:
	var _tempo_label = get_node("CanvasLayer/tempo_por_resp");
	_tempo_label.text = str(int($TLPR.time_left));
	
## Atualiza textos das pontuações dos jogadores
func updateScoresLabels() -> void:
	_points_p1.text = "J1: " + (str(global.pontos[0]));
	_points_p2.text = "J2: " + (str(global.pontos[1]));
	
## Função do loop principal do jogo.
func _process(delta: float) -> void:
	$CanvasLayer/DebugLabel.text = "global.resposta: " + str(global.resposta)
	# Atualizar interface:
	updateTimeLabel()
	updateScoresLabels()
	
	# Detectar alternativa caso tenha um jogador ingressado.
	if global.temJogadorNaVez():
		global.resposta = detectarComando();
		if global.resposta != -1:
			print("A resposta escolhida foi: ", global.resposta)
			$TLPR.stop();
			if checarResposta(global.resposta):
				global.playSound("right");
				audio.stopClock()
				exibirAviso(TIPOS_DE_AVISO.ACERTO);

				adicionarPonto(global.jogadorAtual);
				print("Acertou");
				$next_fortime.start(2)
#				yield(get_tree().create_timer(2.0), "timeout")
#				gerarNovaPergunta();				
			else:
				audio.stopClock()
				global.playSound("wrong");
				adicionarPonto(obterJogadorOposto());
				exibirAviso(TIPOS_DE_AVISO.ERRO);
				$next_fortime.start(2)
				print("Errrouuu");
			global.jogadorAtual = -1;
		global.resposta = -1;
		global.comando = -1;
				
	# Detectar fim de jogo:


	# Detectar entrada de jogadores na vez
	input_signal_players();
	
	# Atualiza cor do plano de fundo
	changeBackgroundByPlayer();
	updateBgColorAlpha();
	
	
## Atualiza os elementos da tela para receberem as informações da pergunta atual.
func atualizarExibicao():
	controle = true
	# Atualiza pergunta
	var _pergunta = perguntaExibida.question


	_questionLabel.text =  _pergunta;
	ajustTextSize()
	# ALTERNATIVAS:
	
	# Cria estrutura de cada pergunta e adiciona num array.
	var _optionsArray = [];
	
	var _alternativas = perguntaExibida.options;	
	#Cria uma no va "estrutura" para casa alternativa(contem agora id e texto)
	#Tem como obejetivo reconhecer a alternativa de posição 0, pois esta sempe é a correta
	for i in range(len(_alternativas)):
		var _optionDict = {
			"id": i,
			"text": _alternativas[i]
		};
		_optionsArray.append(_optionDict);
	
	# Embaralha novo array de alternativas,
	# enquanto não houver a resposta correta nas 3 primeiras.
	_optionsArray.shuffle();
	while (!checkIfHasRightAnswer(_optionsArray)):
		_optionsArray.shuffle();
	
	# Instancia até 3 alternativas
	#Assim é possivel que haja menos  de 3 alternativas, porém nunca será usado
	for i in range(min(3, len(_optionsArray))):
		var _thisOptionDict = _optionsArray[i];
		_opt = optionScene.instance();
		_opt.get_node("Label").text = _thisOptionDict.text;
		_opt.optionID = _thisOptionDict.id;
		
		# Definir posição de cada alternativa: 
		_opt.set_global_position(Vector2(500, 450 + i * 200));
		optionsNode.add_child(_opt);

## Ajusta o texto de perguntas para o tamanho da caixa
func ajustTextSize():
	print(_questionLabel.get_minimum_size().y)
	var fonte  = _questionLabel.get_font("font")
	fonte.size = 100
	while _questionLabel.get_minimum_size().y > 360 and fonte.size > 50:
		print("diminuindo fonte.size")
		fonte.size -= 1
		print((_questionLabel.get_minimum_size().y))


## Checa o array de alternativas e avalia se há correta nas 3 primeiras alternativas
func checkIfHasRightAnswer(_array):
	var have = false;
	for i in range(min(3, len(_array))):
		var opt = _array[i];
		if opt.id == 0:
			have = true
	return have
		
## Atualiza avisos
func exibirAviso(tipoAviso: int):
	# Apagar o texto do aviso caso o tipo seja -1.
	if tipoAviso < 0:
		_label_aviso.text = "";
		return;
		
	var layer = $Perguntas;
	var notices: Array = [];
		
	match tipoAviso:
		TIPOS_DE_AVISO.ERRO:	# Avisos de mensagem incorreta.
			notices = ["Errou!", "Incorreto!", "Resposta errada!"];
		TIPOS_DE_AVISO.ACERTO:	# Avisos de mensagem correta.
			notices = ["Acertou!", "Correto!", "Certa resposta!"];
		TIPOS_DE_AVISO.TEMPO_ESGOTADO:	# Avisos de tempo esgotado:
			notices = ["Tempo esgotado!", "Acabou o tempo!", "Seu tempo acabou!"];
	# Ocultar a pergunta que está sendo exibida.
	layer.layer = -2
	notices.shuffle();
	_label_aviso.text = notices[0];
	

func limparExibicao():
	_questionLabel.text = "[center]";
	for opt in optionsNode.get_children():
		opt.queue_free();


func gerarNovaPergunta(ind = -1):
	var layer = $Perguntas
	layer.layer = 1
	# Limpar alternativas
	limparExibicao()
	
	# Definir pergunta aleatoria caso não seja especificado o índice
	if ind == -1:
		perguntaExibida = getRandomQuestion();
	else:
		# Obter dicionario da pergunta
		perguntaExibida = questions[ind];
	
	atualizarExibicao()
## Tempo da pergunta se esgotou
func _on_TLPR_timeout() -> void:
	# Parar som do relógio
	audio.stopClock()
	# Tocar som do sino
	global.playSound("bell", 3.0);

	# Se houver um jogador na vez, o ponto vai para o jogador oposto.
	if global.temJogadorNaVez():
		# Obter índice do jogador oposto.
		var _sinal = 1 - 2 * global.jogadorAtual;#se vermelho: -1, se azul: 1
		var ganhador = global.jogadorAtual + 1  * _sinal;
		adicionarPonto(ganhador);
	
	$TLPR.stop()
	exibirAviso(TIPOS_DE_AVISO.TEMPO_ESGOTADO)
	$next_fortime.start(2)
	
	
	
	
	
#Para definir quem receberá pontos ao responder a pergunta(apertar em algum botão de alternativa)
#Futuramente será quem enviar o sinal via wu-fi primero, por isso não foi colocado uma condiçao
#de "impedimento" (esp ja tem) ==> @WILLDO
func input_signal_players():
#	return
	var _comandos = ["JogadorAzul", "JogadorVermelho"];
	var _comandosEsp = ["B1", "B2"];
	var _atual = -1

	for i in range(len(_comandos)):
		# Capturar ação do teclado
		if Input.is_action_just_pressed(_comandos[i]):
			_atual += i + 1;
	
	# Se apenas um jogador apertou:
	if (_atual >= 0 and _atual < 2) and controle == true:
		print("pode passar")
		global.definirJogadorAtual(_atual);
		colorProgress = 0.0;
		$TLPR.start(10)
		controle = false
		#retirar
		audio.startClock()
	elif (_atual >= 0 and _atual < 2) and controle == false:
		print("epa epa epa")
		pass
	else:
		# Aconteceu de ninguém apertar, ou dos dois apertarem no mesmo instante.
		pass

func blueIn():
	print("Botão azul pressionado.")
	if global.temJogadorNaVez():
		print("Já havia jogador na vez.")
		audio.stopClock()
		return
	colorProgress = 0.0;
	global.definirJogadorAtual(0)
	$TLPR.start(10)
	audio.startClock()

func redIn():
	print("Botão vermelho pressionado.")
	if global.temJogadorNaVez():
		print("Já havia jogador na vez.")
		audio.stopClock()
		return
	colorProgress = 0.0;
	global.definirJogadorAtual(1)
	$TLPR.start(10)
	audio.startClock()


func changeBackgroundByPlayer():
	var _bgText = get_node("CanvasLayer/CorRespondedor").texture.gradient as Gradient;
	
	if global.jogadorAtual == 0:
		_bgText.colors[0] = Color(0,0.7,1, 0.21);
	elif global.jogadorAtual == 1:
		_bgText.colors[0] = Color(1,0.2,0.2, 0.21);
	else:
		_bgText.colors[0] = Color.white;
		

func updateBgColorAlpha():
	# Se alguem tiver apertado: 
	colorProgress = move_toward(colorProgress, float(global.temJogadorNaVez()), 0.068);
		
	var _bgText = get_node("CanvasLayer/CorRespondedor").texture.gradient as Gradient;
	_bgText.colors[0].a = colorProgress;
		


## Detecta os comandos das alternativas e retorna  o indice selecionado.
func detectarComando():
	#@TODO: mudar pelos sinais
	var comandos = ["A", "B", "C"]
	for i in range(len(comandos)):
		if Input.is_action_just_pressed(comandos[i]):
			return i;
	return -1;

		
## Confere se a alternativa selecionada é a correta.
func checarResposta(ind):
	var _optionToCheck = optionsNode.get_child(ind) as Alternativa;
	if _optionToCheck:
#		correct.set_global_position(500,250)
#		correctNode.add_child(correct)
#		_opt.get_node("Certon").visible = _optionToCheck.optionID != 0
		return _optionToCheck.optionID == 0
	return false

## Torna visivel efeitos de acerto de acordo com o jogador desejado.
func exibirEfeitoDeAcerto(indJogador):
	var _label_ponto = get_node("CanvasLayer2/add_point");
	_label_ponto.visible = true;
	var _colors = [Color.dodgerblue, Color.red]
	_label_ponto.set_modulate(_colors[indJogador]);

## Adiciona um ou mais pontos para o jogador desejado
func adicionarPonto(indJogador, qntPontos = 1):
	global.pontos[indJogador] += qntPontos;
	exibirEfeitoDeAcerto(indJogador);
	$AddPointEffectTimer.start(0.5)
	
	if global.pontos[0] == global.maxPoints or global.pontos[1] == global.maxPoints:
		callGameOver();

## Retorna a pergunta novamente
func _on_next_fortime_timeout() -> void:
	global.jogadorAtual = -1;
	exibirAviso(-1)
	$next_fortime.stop();
	gerarNovaPergunta();
	# Adicionar pergunta gerada ao array de perguntas exibidas, para evitar que
	# ela se repita.
	displayedQuestionIds.append(perguntaExibida.id)
	$TLPR.stop();

## Sinaliza quando o efeito de adição de pontos se encerrar.
func _onAddPointEffectTimerTimeout():
	$CanvasLayer2/add_point.visible = false
	
## Chamado para finalização da rodada entre os competidores
## @TODO: Exibe jogador vencedor e passa pra menu de fim
func callGameOver():
	global.getTransition(0,"fim")

func get_questionsData() -> Array:
	print("[get_questionsData] Obtendo banco de dados de perguntas.")
	var file : File = File.new()
	## Cainho para o arquivo de perguntas json.
	var questions_file_path = "res://Data/questions.json"
	file.open(questions_file_path, File.READ)
	var content = file.get_as_text()
	var result = JSON.parse(content).result
	file.close()
	return result
