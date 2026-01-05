@tool
extends Label3D

func start():
	font_size = 1
	outline_size = 0
	
	
	
	var t = get_tree().create_tween()
	
	t.tween_property(self, "font_size", 60, 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property($Label,"visible_ratio", 1.0, 0.5).set_trans(Tween.TRANS_LINEAR)
	t.tween_property(self, "outline_size", 20, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	

func exit():
	font_size = 60
	outline_size = 20
	var t = get_tree().create_tween()
	t.tween_property(self, "outline_size", 0, 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property(self, "font_size", 1, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	

var wamr = 1
func _process(delta: float) -> void:
	var labeltextsize = $Label.text.length()
	var nextlabelsize = roundf(labeltextsize * $Label.visible_ratio)
	var new_string = $Label.text.replace($Label.text.substr(nextlabelsize,labeltextsize), "")
	text = new_string
	wamr += 1
	if wamr % 500 == 0:
		$Label.visible_ratio = 0.0
		labeltextsize = $Label.text.length()
		nextlabelsize = roundf(labeltextsize * $Label.visible_ratio)
		new_string = $Label.text.replace($Label.text.substr(nextlabelsize,labeltextsize), "")
		text = new_string
		start()
	elif wamr % 250 == 0:
		exit()
