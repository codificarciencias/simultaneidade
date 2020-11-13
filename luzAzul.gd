extends Node2D

#-----------------Script da Luz Azul--------------

var marcar = true

func _ready():
	add_to_group('azul')
	$luzFx.play()
	
	
func _process(delta):
	
	if marcar == true:
		$MarcaA.visible = true
	else:
		$MarcaA.visible = false
	
	$ColAzul/ShapeAz.scale.x += 100.5*delta
	$ColAzul/ShapeAz.scale.y += 100.5*delta
	
	if $ColAzul/ShapeAz.scale.x >= 800:
		queue_free()
