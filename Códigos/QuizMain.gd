extends Node2D
#INFORMAÇÃO: TLPR significa tempo limite por pergunat


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
]


## Dicionario de pergunta atualmente sendo exibido.
var perguntaExibida = null;

# Indice da pergunta atual
var actualQuestionInd = 0;
#Cena de alternativas
onready var optionsNode = get_node("Options");

onready var optionScene = preload("res://Cenas/alternativa.tscn");

func _ready() -> void:
	randomize()
	
	# Define qual pergunta será exibida
	perguntaExibida = questions[0];
	
	# Atualiza a exibição
	atualizarExibicao();
	
## Atualiza os elementos da tela para receberem as informações da pergunta atual.
func atualizarExibicao():
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
		_opt.text = _thisOptionDict.text;
		_opt.optionID = _thisOptionDict.id;
		
		# Definir posição de cada alternativa: 
		_opt.set_global_position(Vector2(1200, 1000 + i * 96));
		optionsNode.add_child(_opt);


## Checa o array de alternativas e avalia se há correta nas 3 primeiras alternativas
func checkIfHasRightAnswer(_array):
	var have = false;
	for i in range(min(3, len(_array))):
		var opt = _array[i];
		if opt.id == 0:
			have = true
	return have
		


func _process(delta: float) -> void:
	# Para fins de teste, avançar pergunta
	if Input.is_action_just_pressed("ui_page_up") and global.resp_p1 == 1:
		actualQuestionInd += 1
		gerarNovaPergunta()
		#reseta as variavies de definição de recebimento dos pontos
		global.pontos_p1 += 1
		global.resp_p1 = 0;
		global.resp_p2 = 0;
	if Input.is_action_just_pressed("ui_page_up") and global.resp_p2 == 1:
		actualQuestionInd += 1
		gerarNovaPergunta()
		#reseta as variavies de definição de recebimento dos pontos
		global.pontos_p2 += 1
		global.resp_p1 = 0;
		global.resp_p2 = 0;
	input_signal_players();


func limparExibicao():
	$Pergutas_teste.text = "";
	for opt in optionsNode.get_children():
		opt.queue_free();		


func gerarNovaPergunta(ind = actualQuestionInd):
	# Limpar alternativas
	limparExibicao()
	
	# Obter dicionario da pergunta
	perguntaExibida = questions[ind];
	
	atualizarExibicao()


func _on_TLPR_timeout() -> void:
	pass # Replace with function body.
	
#Para definir quem receberá pontos ao responder a pergunta(apertar em algum botão de alternativa)
#Futuramente será quem enviar o sinal via wu-fi primero, por isso não foi colocado uma condiçao
#de "impedimento" (esp ja tem) ==> @WILLDO
func input_signal_players():
	if Input.is_action_just_pressed("JogadorAzul"):
		global.resp_p1 = 1
		
	if Input.is_action_just_pressed("JogadorVermelho"):
		global.resp_p2 = 1
		
