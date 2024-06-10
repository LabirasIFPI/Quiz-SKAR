extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	global.getTransition(1)
	$Labels/rav.bbcode_text = "kaslhadlisfcdsbcbiwviwvbibvwbivwb"
	


func _process(delta):
	$Labels/rav.percent_visible += 0.01


func _on_out_pressed():
	global.getTransition(0, "menu")
