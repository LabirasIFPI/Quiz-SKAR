extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	global.getTransition(1)
	$Labels/rav.bbcode_text = "[b]Ravena: [/b] fez tudo"
	$Labels/sof.bbcode_text = "[b]Sofia: [/b] fez tal tal tal tal"
	$Labels/anni.bbcode_text = "[b]Anésia: [/b] fez tal tal tal tal"
	$Labels/kactus.bbcode_text = "[b]Kactus: [/b] nome do massacote :)"


func _process(delta):
	$Labels/rav.percent_visible += 0.01
	$Labels/sof.percent_visible += 0.01
	$Labels/anni.percent_visible += 0.01
	$Labels/kactus.percent_visible += 0.01


func _on_out_pressed():
	global.getTransition(0, "menu")


func _on_Ani_mouse_entered():
	pass # Replace with function body.


func _on_Sof_mouse_entered():
	print("troj")
	pass # Replace with function body.


func _on_Rav_mouse_entered():
	$Labels/rav.percent_visible = 0
	$Labels/rav.visible = true
	print("trouu")
	pass # Replace with function body.


func _on_Kac_mouse_entered():
	pass # Replace with function body.
