extends Node2D

# Variaveis
var fase = 0 # Fase atual
# Fases pré carregadas
var fase0 = preload("res://intro.tscn") # intro
var fase1 = preload("res://fase_1/fase1.tscn") # Dolly guarana Dolly

# Função chamada quando o jogo é iniciado
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	carrega_intro()

# Função pra carregar a fase1 quando tiver no portão
func _on_intro_fase1():
	fase = 1
	remove_child(get_node("intro"))
	add_child(fase1.instance())

# Função que prepara a fase da introdução e adiciona
func carrega_intro(saindo_fase = 0):
	fase = 0
	var intro = fase0.instance()
	intro.connect("fase1", self, "_on_intro_fase1")
	if saindo_fase == 1:
		intro.acabou_fase1()
	add_child(intro)

func carrega_fase1():
	fase = 1
	var fasei = fase1.instance()
	fasei.connect("acabou", self, "acabou_fase1")
	add_child(fasei)

func acabou_fase1():
	remove_child(get_node("fase1"))
	carrega_intro(1)

# Funções que interagem com o menu de pausa
# Reinicia fase atual
func reinicia():
	if fase == 0:
		remove_child(get_node("intro"))
		carrega_intro()
	elif fase == 1:
		remove_child(get_node("fase1"))
		carrega_fase1()
		

# Vai pra fase inicial, da estrada
func tela_inicial():
	if fase == 0:
		remove_child(get_node("intro"))
	elif fase == 1:
		remove_child(get_node("fase1"))
	fase = 0
	carrega_intro()
