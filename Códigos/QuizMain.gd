extends Node2D
# INFORMAÇÃO: TLPR significa tempo limite por pergunat


## Banco de dados de perguntas:
var questions: Array = [
	{
		"id": 1,
		"question": "Qual é a capital do Brasil?",
		"options": [ 
			"Brasilia", 
			"Rio de Janeiro", 
			"Salvador", 
			"São Paulo", 
			"Belo Horizonte", "Recife", "Fortaleza", "Curitiba", "Manaus", "Porto Alegre", "Goiânia", "Belém", "Campinas", "São Luís", 
			"Natal", "João Pessoa", "Teresina", "Cuiabá", "Campo Grande", "Florianópolis" ]
	},
	{
		"id": 2,
		"question": "Pessoa mais estranha do laboratorio?",
		"options": [
			"Fabricio",
			"Patrocinio",
			"Ryan",
			"Sofia",
			"Ravena"
		]
	},
	{
		"id": 3,
		"question": "Qual das seguintes frases está correta quanto ao uso dos porquês?",
		"options": [
			"Eu não sei por que ele não veio.",
			"Eu não sei porquê ele não veio.",
			"Eu não sei por quê ele não veio.",
			"Eu não sei porque ele não veio.",
		]
	},
	{
		"id": 4,
		"question": "Qual é a raiz quadrada de 144?",
		"options": [
			"12",
			"10",
			"14",
			"16"]
	},	
	{
		"id": 5,
		"question": "Qual é o processo pelo qual as plantas convertem a luz solar em energia química?",
		"options": [
			"Fotossíntese",
			"Respiração celular",
			"Fermentação",
			"Oxidação"]
		
	},
	{
		"id": 6,
		"question": "Qual período da história romana é marcado pelo governo de imperadores?",
		"options": [
			 "Império Romano",
			"República Romana",
			"Monarquia Romana",
			"Era das Invasões Bárbaras"]
	
	},
	{
		"id": 7,
		"question": "Qual é o símbolo químico para o elemento oxigênio?",
		"options": [
			"O",
			"Ox",
			"Os",
			"O2"]
	},
	{
		"id": 8,
		"question": "Qual é o nome dado à linha imaginária que divide a Terra em Hemisfério Oriental e Hemisfério Ocidental?",
		"options": [
			"Meridiano de Greenwich",
			"Trópico de Câncer",
			"Linha do Equador",
			"Meridiano de Primeiro de Janeiro"]
	},
	{
		"id": 9,
		"question": "Qual o valor de π (pi)?",
		"options": [
			"3,14",
			"2,71",
			"1,61",
			"4,20"
	]
},
	{
	"id": 10,
	"question": "Qual é o processo pelo qual as plantas convertem a luz solar em energia?",
	"options": [
		"Fotossíntese",
		"Respiração",
		"Transpiração",
		"Digestão"
	]
},
{
	"id": 11,
	"question": "Quem foi o primeiro presidente dos Estados Unidos?",
	"options": [
		"George Washington",
		"Abraham Lincoln",
		"Thomas Jefferson",
		"John Adams"
	]
},
{
	"id": 12,
	"question": "Qual é a capital da França?",
	"options": [
		"Paris",
		"Londres",
		"Madrid",
		"Berlim"
	]
},
	{
	"id": 13,
	"question": "Qual é o principal hormônio feminino?",
	"options": [
		"Estrogênio",
		"Testosterona",
		"Progesterona",
		"Cortisol"
	]
},
{
	"id": 14,
	"question": "Qual é o resultado da expressão matemática: 3 + 4 * 2 - 6 ÷ 2 ?",
	"options": [
		"9",
		"7",
		"8",
		"10"
	]
},
{
	"id": 15,
	"question": "Quem escreveu o livro 'Dom Casmurro'?",
	"options": [
		"Machado de Assis",
		"José de Alencar",
		"Carlos Drummond de Andrade",
		"Graciliano Ramos"
	]
},
	{
	"id": 16,
	"question": "Quem foi o primeiro presidente do Brasil?",
	"options": [
		"Deodoro da Fonseca",
		"Petrônio Portela",
		"Getúlio Vargas",
		"Juscelino Kubitschek",
		"Tancredo Neves"
	]
},
{
	"id": 17,
	"question": "Qual é o maior rio do mundo em volume de água?",
	"options": [
		"Rio Amazonas",
		"Rio Nilo",
		"Rio Yangtzé",
		"Rio Mississippi",
		"Rio Paraná"
	]
},
{
	"id": 18,
	"question": "Qual foi o evento que marcou o início da Revolução Francesa em 1789?",
	"options": [
		"Tomada da Bastilha",
		"Marcha das Mulheres a Versalhes",
		"Execução de Luís XVI",
		"Lei dos Chapeliers",
		"Constituição Civil do Clero"
	]
},
{
	"id": 19,
	"question": "Qual foi o tratado que encerrou a Primeira Guerra Mundial?",
	"options": [
		"Tratado de Versalhes",
		"Tratado de Tordesilhas",
		"Tratado de Paris",
		"Tratado de Washington",
		"Tratado de Brest-Litovsk"
	]
},
{
	"id": 20,
	"question": "Qual o país mais populoso da América do Sul?",
	"options": [
		"Brasil",
		"Argentina",
		"Colômbia",
		"Peru",
		"Chile"
	]
},
{
	"id": 21,
	"question": "Qual é o ponto mais alto do planeta Terra?",
	"options": [
		"Monte Everest",
		"Monte Kilimanjaro",
		"Monte Aconcágua",
		"Monte Denali",
		"Monte Vinson"
	]
},
{
	"id": 22,
	"question": "Quem foi o líder da Revolução Cubana em 1959?",
	"options": [
		"Fidel Castro",
		"Che Guevara",
		"Raul Castro",
		"Hugo Chávez",
		"Nicolás Maduro"
	]
},
{
	"id": 23,
	"question": "Qual foi a primeira civilização da Mesopotâmia?",
	"options": [
		"Suméria",
		"Babilônia",
		"Assíria",
		"Acarta",
		"Ebla"
	]
},
{
	"id": 24,
	"question": "Qual foi o período em que ocorreu a Idade Média na Europa?",
	"options": [
		"Entre os séculos V e XV",
		"Entre os séculos XV e XVII",
		"Entre os séculos III e VII",
		"Entre os séculos XVI e XVIII",
		"Entre os séculos I e IV"
	]
},
{
	"id": 25,
	"question": "Qual é o nome da fronteira entre Estados Unidos e México?",
	"options": [
		"Rio Grande",
		"Rio Amazonas",
		"Rio Mississipi",
		"Rio Missouri",
		"Rio Colorado"
	]
}
]

onready var _label_aviso = get_node("CanvasLayer2/aviso")
## Dicionario de pergunta atualmente sendo exibido.
var perguntaExibida = null;

# Indice da pergunta atual
var actualQuestionInd = 0;

#Cena de alternativas
onready var optionsNode = get_node("Options");

onready var _points_p1 = get_node("CanvasLayer/pontos_p1")
onready var _points_p2 = get_node("CanvasLayer/pontos_p2")

## Cena da alternativa
onready var optionScene: PackedScene = preload("res://Cenas/alternativa.tscn");

var colorProgress: float = 0.0;

func _ready() -> void:
	randomize()
	
	# Define qual pergunta será exibida
	perguntaExibida = questions[0];
	
	# Atualiza a exibição
	atualizarExibicao();
	
## Atualiza os elementos da tela para receberem as informações da pergunta atual.
func atualizarExibicao():
	var _questions_array= []

	
	# Atualiza pergunta
	var _pergunta = perguntaExibida.question;
	#@TODO apos acabar sessão de testess, mudar a spritename
	var _questionLabel = get_node("Pergutas_teste");
	_questionLabel.text = _pergunta;
	
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
		var _opt = optionScene.instance();
		_opt.get_node("Label").text = _thisOptionDict.text;
		_opt.optionID = _thisOptionDict.id;
		
		# Definir posição de cada alternativa: 
		_opt.set_global_position(Vector2(500, 400 + i * 200));
		optionsNode.add_child(_opt);


## Checa o array de alternativas e avalia se há correta nas 3 primeiras alternativas
func checkIfHasRightAnswer(_array):
	var have = false;
	for i in range(min(3, len(_array))):
		var opt = _array[i];
		if opt.id == 0:
			have = true
	return have
		

##############################################################
func _process(delta: float) -> void:
	var correta 
	var _tempo_label = get_node("CanvasLayer/tempo_por_resp")

	_tempo_label.text = str(int($TLPR.time_left))
	_points_p1.text = "J1: " + (str(global.pontos_p1))
	_points_p2.text = "J2: " + (str(global.pontos_p2))
	
	# Para fins de teste, avançar pergunta
	
	
	#LEMBRAR: pageup substitui alguma alternativa
	if global.resp_p1 or global.resp_p2:
		alt_A()
		alt_B()
		alt_C()
		if global.resposta != -1:
			if checarResposta(global.resposta):
				correta = 1
				print("Acertou");
			else:
				correta = 0
				print("Errrouuu");


	if global.resp_p1 == true and Input.is_action_just_pressed("ui_page_up"):
		$TLPR.stop()
		_label_aviso.text = ""
		actualQuestionInd += 1
		gerarNovaPergunta()
		#reseta as variavies de definição de recebimento dos pontos
		ponto_blue()

	if global.resp_p2 == true and Input.is_action_just_pressed("ui_page_up"):
		$TLPR.stop()
		_label_aviso.text = ""
		actualQuestionInd += 1
		gerarNovaPergunta()
		#reseta as variavies de definição de recebimento dos pontos
		ponto_red()

	input_signal_players();
	
	updateBgColor();
	
	# Detectar entrada de alternativa se tiver um jogador ingressado

###########################################################end


func limparExibicao():
	$Pergutas_teste.text = "";
	for opt in optionsNode.get_children():
		opt.queue_free();		


func gerarNovaPergunta(ind = actualQuestionInd):
	# Limpar alternativas
	limparExibicao()
	
	# Obter dicionario da pergunta
	perguntaExibida = questions[ind];2
	
	atualizarExibicao()


func _on_TLPR_timeout() -> void:
	if global.resp_p1:
		print("zuuullllll")
		ponto_red()
	else:
		print("reedddd")
		ponto_blue()
	$TLPR.stop()
	_label_aviso.text = str("Seu tempo acabou :(")
	$next_fortime.start(2)
	
	
#Para definir quem receberá pontos ao responder a pergunta(apertar em algum botão de alternativa)
#Futuramente será quem enviar o sinal via wu-fi primero, por isso não foi colocado uma condiçao
#de "impedimento" (esp ja tem) ==> @WILLDO
func input_signal_players():
	if Input.is_action_just_pressed("JogadorAzul"):
		global.resp_p1 = true;
		$TLPR.start(10)
		changeBackgroundByPlayer();
		
	if Input.is_action_just_pressed("JogadorVermelho"):
		global.resp_p2 = true;
		$TLPR.start(10)
		changeBackgroundByPlayer();
		


func changeBackgroundByPlayer():
	var _bgText = get_node("CanvasLayer/CorRespondedor").texture.gradient as Gradient;
	colorProgress = 0.0;
	
	if global.resp_p1 and not global.resp_p2:
		_bgText.colors[0] = Color(0,0.7,1, 0.21);
	elif global.resp_p2 and not global.resp_p1:
		_bgText.colors[0] = Color(1,0.2,0.2, 0.21);
	else:
		_bgText.colors[0] = Color.white;
		

func updateBgColor():
	# Se alguem tiver apertado: 
	if global.resp_p1 or global.resp_p2:
		colorProgress = move_toward(colorProgress, 1.08, 0.068);
		
	var _bgText = get_node("CanvasLayer/CorRespondedor").texture.gradient as Gradient;
	_bgText.colors[0].a = colorProgress;
		

#Essas funções serão atribuídas aos sinais que serão recebidos pelo Esp32
func alt_A():
	if Input.is_action_just_pressed("A"):#substituida por sinais(será o novo "pageup")
		global.resposta = 0;
		$TLPR.stop()
		
func alt_B():
	if Input.is_action_just_pressed("B"):
		global.resposta = 1;
		$TLPR.stop()		
		
func alt_C():
	if Input.is_action_just_pressed("C"):
		global.resposta = 2;
		$TLPR.stop()
		
## Confere se a alternativa selecionada é a correta.
func checarResposta(ind):
	var _optionToCheck = optionsNode.get_child(ind) as Alternativa;
	if _optionToCheck:
		return _optionToCheck.optionID == 0
	return false


func ponto_red():#WILLDO confiderar se a reszposta foi errada
	global.pontos_p2 += 1
	global.resp_p1 = 0;
	global.resp_p2 = 0;
	var _label_ponto = get_node("CanvasLayer2/add_point")
	_label_ponto.visible = true
	_label_ponto.set_modulate(Color.red)
	$Timer.start(0.5)
		
func ponto_blue(): #futuramente considerar se a resposta foi errada
	global.pontos_p1 += 1
	global.resp_p1 = 0;
	global.resp_p2 = 0;
	var _label_ponto = get_node("CanvasLayer2/add_point")
	_label_ponto.visible = true
	_label_ponto.set_modulate(Color.dodgerblue)
	$Timer.start(0.5)
	

func _on_Timer_timeout() -> void:
	$CanvasLayer2/add_point.visible = false


func _on_next_fortime_timeout() -> void: #pra retornar às perguntas normalmwengte :( :(
	global.resp_p1 = false
	global.resp_p2 = false
	_label_aviso.text = str("")
	$next_fortime.stop()
	actualQuestionInd += 1
	gerarNovaPergunta()
	$TLPR.stop()

