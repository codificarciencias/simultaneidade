extends Node2D

var marcar = true

func _ready():
	add_to_group('vermelho')
	

func _process(delta):
	
	if marcar == true:
		$MarcaV.visible = true
	else:
		$MarcaV.visible = false
	
	$ColVerm/ShapV.scale.x += 100.5*delta
	$ColVerm/ShapV.scale.y += 100.5*delta
	
	if $ColVerm/ShapV.scale.x >= 800:
		queue_free()

