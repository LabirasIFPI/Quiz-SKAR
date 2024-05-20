extends CanvasLayer

signal acabou(Importante, Menu, FimDeJogo, Aviso)

func _ready() -> void:
	pass



func _on_trasiotion_finished(anim_name: String) -> void:
	print("caboucaboucabou")
	emit_signal("acabou")
