extends Label
var som = true


func _process(delta):
	# efeito iniciar
	
		
		
	if rect_position.x > 450 or rect_position.x < 250:
		rect_global_position.x -=50
	elif rect_position.x < 450 and rect_position.x > 250:
		rect_global_position.x -=5
		if som:
			$Iniciar.play()
			som = false
	
	if rect_position.x < -570:
		queue_free()
