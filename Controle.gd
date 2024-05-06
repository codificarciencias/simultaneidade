extends Node

func _ready():
	pass # Replace with function body.



func _process(_delta):
	# Comandos de teclas
	if Input.is_action_just_pressed("tc_pulsar"):
		$".."._on_btLuz_pressed()
	
	if Input.is_action_just_pressed("tc_pause"):
		if get_tree().paused == true:
			$".."._on_btPlay_pressed()
		else:
			$".."._on_btPause_pressed()
			
			
	if Input.is_action_just_pressed("tc_cam_lenta"):
		$".."._on_btLenta_button_down()
	if Input.is_action_just_released("tc_cam_lenta"):
		$".."._on_btLenta_button_up()



func _on_btInfo_button_down():
	$btInfo/spInform.visible = true


func _on_btInfo_button_up():
	$btInfo/spInform.visible = false
