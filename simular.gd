extends Node2D

var velocid = 30
var mover = false
var luzVerm = preload("res://luzVerm.tscn")
var luzAz = preload("res://luzAzul.tscn")
var tremDirec = 'centro'


#------------------------ Execução Inicial -------------------------------------

func _ready():
	pass

#---------------------------- Process (FPS)-------------------------------------

func _process(delta):
	
	# Exibe data e hora
	$Controle/LbData.text = str('Data: ', '%02d'% OS.get_date()['day'], '-', 
	'%02d'% OS.get_date()['month'],'-', OS.get_date()['year'], 
	' Hora: ', '%02d'% OS.get_time()['hour'],' : ', '%02d'% OS.get_time()['minute'],' : ', 
	'%02d'% OS.get_time()['second'])
	
	if mover == true: # mover o trem 
		$Trem.translate(Vector2(velocid, 0) * delta)
	else: # controla o botão play e pause
		$Controle/btPlay.visible = true
		$Controle/btPause.visible = false
		
	if $Trem.position.x <= -300: # Trajeto do trem para direita
		$Trem.position.x = 280
		velocid = $Controle/VelTrem.value
		mover = false
		tremDirec = 'dir'
		$Controle/btPlay.rect_rotation = 0
	elif $Trem.position.x >= 1580: # Trajeto do trem para esquerda
		$Trem.position.x = 1000
		velocid = $Controle/VelTrem.value * -1
		mover = false
		tremDirec = 'esq'
		$Controle/btPlay.rect_rotation = 180
		
	
	if $Controle/LuzAutomatca.pressed == true: # Dispara a luz quando o trem alinhar na estação
		if $Trem/posCentro.global_position.x >= $Estacao.position.x and tremDirec == 'dir' :
			_on_btLuz_pressed()
			tremDirec = 'nulo'
		elif $Trem/posCentro.global_position.x <= $Estacao.position.x and tremDirec == 'esq' :
			_on_btLuz_pressed()
			tremDirec = 'nulo'

#----------------------------Controle de Eventos -------------------------------

func _on_btEsq_pressed(): # posiciona o trem na esquerda
	mover = false
	$Trem.position.x = 280
	tremDirec = 'dir'
	$Controle/btPlay.rect_rotation = 0
	

func _on_btPlay_pressed(): # inicia a simulação
	mover = true
	$Controle/btPlay.visible = false
	$Controle/btPause.visible = true
	get_tree().paused = false
	# Atribui valor a velocidade do trem
	if tremDirec == 'esq': 
		velocid = $Controle/VelTrem.value * -1
	elif tremDirec == 'dir':
		velocid = $Controle/VelTrem.value
	elif tremDirec == 'centro':
		# O trem vai na direção onde o play aponta
		if $Controle/btPlay.rect_rotation == 0:
			velocid = $Controle/VelTrem.value
		else:
			velocid = $Controle/VelTrem.value * -1
		# Dispara a luz quando o trem parte do centro, com luz automática
		if $Controle/LuzAutomatca.pressed == true:
			_on_btLuz_pressed()
			tremDirec = 'nulo'


func _on_btDir_pressed(): # posiciona o trem a direita
	mover = false
	$Trem.position.x = 1000
	tremDirec = 'esq'
	$Controle/btPlay.rect_rotation = 180


func _on_btCentro_pressed(): # posiciona o trem no centro
	mover = false
	$Trem.position.x = 651
	tremDirec = 'centro'


func _on_btPause_pressed(): # pausa a simulação
	$Controle/btPlay.visible = true
	$Controle/btPause.visible = false
	get_tree().paused = true


func _on_btFechar_pressed() -> void: # Encerra o aplicativo
	#OS.shell_open("https://codificarciencias.github.io")
	get_tree().quit()


func _on_btLuz_pressed(): # Dispara as luzes
	var luzvermelha = luzVerm.instance()
	var luzAzul = luzAz.instance()
	add_child(luzvermelha)
	add_child(luzAzul)
	if $Controle/EmisTrem.pressed == true: # se os emissores estiverem no trem...
		luzvermelha.global_position = $Trem/posVerm.global_position
		luzAzul.global_position = $Trem/posAzul.global_position
	else: # se os emissores estiverem na estação
		luzvermelha.global_position = $Estacao/PosV.global_position
		luzAzul.global_position = $Estacao/PosA.global_position

	if $Controle/Marcar.pressed == true: # deixa a marca do momento e local da emissão
		luzvermelha.marcar = true
		luzAzul.marcar = true
	else: # marcas desativadas
		luzvermelha.marcar = false
		luzAzul.marcar = false


func _on_btLenta_button_down(): # Ativa a camera lenta ao pressionar
	Engine.time_scale = 0.2


func _on_btLenta_button_up(): # Destiva a camera lenta ao soltar
	Engine.time_scale = 1


func _on_EmisEStacao_pressed(): # posiciona os emissores na Estação
	$Controle/EmisEStacao.pressed = true
	$Controle/EmisTrem.pressed = false
	$Estacao/EstaLampA.visible = true
	$Estacao/EstaLampV.visible = true
	$Trem/lampA.visible = false
	$Trem/lampV.visible = false


func _on_EmisTrem_pressed(): # posiciona os emissores no Trem
	$Controle/EmisTrem.pressed = true
	$Controle/EmisEStacao.pressed = false
	$Estacao/EstaLampA.visible = false
	$Estacao/EstaLampV.visible = false
	$Trem/lampA.visible = true
	$Trem/lampV.visible = true


func _on_kinTrem_area_entered(area): # Emite som ao colidir luzes e trem
	if $Controle/SonTrem.pressed == true:
		if area.name == 'ColVerm':
			$VermFX.play()
		elif area.name == 'ColAzul':
			$AzulFx.play()


func _on_kinEstacao_area_entered(area): # Emite som ao colidir luzes e estacao
	if $Controle/SonEstacao.pressed == true:
		if area.name == 'ColVerm':
			$VermFX.play()
		elif area.name == 'ColAzul':
			$AzulFx.play()


func _on_btTela_pressed(): # Modo tela cheia
	if OS.window_fullscreen == true:
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true


func _on_Wsite_pressed(): # Link para o site
	OS.shell_open("https://codificarciencias.github.io")


func _on_btReset_pressed(): # Reinicia a simulação
	get_tree().paused = false
	get_tree().reload_current_scene()
