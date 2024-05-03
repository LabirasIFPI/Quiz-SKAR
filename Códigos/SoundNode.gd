extends Node

class_name SoundNode

export var soundToPlay: Resource = null;
export var timeToDestroy: float = 5.0;

onready var timer: Timer = get_node("Timer");
onready var audioStream: AudioStreamPlayer = get_node("AudioStreamPlayer");

## Inicializar SoundNode
func _ready() -> void:
	# Configurar áudio a ser tocado
	audioStream.stream = soundToPlay;
	audioStream.play();
	
	# Configurar tempo de destruição
	timer.wait_time = timeToDestroy;
	timer.start();


func _onTimerTimeout() -> void:
	queue_free();


func _onAudioStreamPlayerFinished() -> void:
	queue_free();
