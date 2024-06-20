extends Button

## Classe responsável por gerenciar as animações comuns a todos os botões.

func _ready():
	# Conectar método pressed do botão a função _onPress.
	self.connect("pressed", self, "_onPress");
	WebSocket.connect("azul", self, "_onPress")
func _process(_delta):
	# O botão sempre estará tentando voltar a sua escala original.
	rect_scale = rect_scale.linear_interpolate(Vector2(1.0, 1.0), 0.168);

func _onPress():
	# Aumentar escala do botão ao ser pressionado.
	rect_scale = Vector2(1.20, 1.20);
