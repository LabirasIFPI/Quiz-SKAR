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
]

## Dicionario de pergunta atualmente sendo exibido.
var perguntaExibida = null;

# Indice da pergunta atual
var actualQuestionInd = 0;

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
	var _questionLabel = get_node("Pergutas_teste");
	_questionLabel.text = _pergunta;
	
	# ALTERNATIVAS:
	
	# Cria estrutura de cada pergunta e adiciona num array.
	var _optionsArray = [];
	
	var _alternativas = perguntaExibida.options;	
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
	for i in range(min(3, len(_optionsArray))):
		var _thisOptionDict = _optionsArray[i];
		var _opt = optionScene.instance();
		_opt.text = _thisOptionDict.text;
		_opt.optionID = _thisOptionDict.id;
		
		# Definir posição de cada alternativa: 
		_opt.set_global_position(Vector2(300, 300 + i * 96));
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
	if Input.is_action_just_pressed("ui_page_up"):
		actualQuestionInd += 1
		gerarNovaPergunta()


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
