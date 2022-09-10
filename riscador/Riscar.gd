# marcador para apontar e destacar objetos na tela

# ******************************************************************************
#    ADICIONAR ENTRADAS EM CONFIGURAÇÃO DO PROJETO PARA FUNCIONAR
# ******************************************************************************
#Entradas
	# mouseRigth = atribuir botão direito do mouse
	# mouseLeft = atribuir botão Esquerdo do mouse
	# Riscador = atribuir tecla que ativa a caneta para riscar(shift)
# Arrastar a cena Riscar.tscn como no filho da cena principal

extends Node2D

var riscar = preload("res://riscador/Risco.tscn")
var lista = []
var cont


func _ready():
	#limpa e inicia o marcador
	cont = 0
	lista.clear()
	lista.append(riscar.instance())
	add_child(lista[0])


# ciclo de quadros por segundo (FPS) ===========================================
func _process(delta):

# Eventos do riscador

#    ENTRADA DO MOUSE
	if Input.is_action_just_pressed("mouseRigth"): # limpar tela
		_ready()
	#risca a tela com shift pressionado (Riscador = shift)	
	elif Input.is_action_pressed("mouseLeft") and Input.is_action_pressed("Riscador"):
		lista[cont].add_point(Vector2(get_global_mouse_position().x, get_global_mouse_position().y))
	
	elif Input.is_action_just_released("mouseLeft"): # carrega novo risco
		cont+=1
		lista.append(riscar.instance())
		add_child(lista[cont])
	#fim do evento do riscador
