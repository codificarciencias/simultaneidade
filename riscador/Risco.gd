extends Line2D


func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("mouseRigth")and Input.is_action_pressed("Riscador"):
		.clear_points()
		
