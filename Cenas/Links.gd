extends Node2D

export var url_rav = "https://github.com/RavCarvalho"
export var url_anni = "https://www.linkedin.com/in/an%C3%ADsia-beatriz-moura-brand%C3%A3o-611416265/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app"
export var url_sofia = "https://www.linkedin.com/in/sofia-heisenberg-lima-veloso-a87127265/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_linkRav_pressed() -> void:
	OS.shell_open(url_rav)


func _on_linkAni_pressed() -> void:
	OS.shell_open(url_anni)


func _on_linkSof_pressed() -> void:
	OS.shell_open(url_sofia)
