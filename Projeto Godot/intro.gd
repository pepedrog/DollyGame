extends Node2D

signal fase1
signal fase2
signal fase3

# Variaveis da fase
onready var dollynho_scene = preload("res://dollynho.tscn") # Cena do dollynho
var dollynho # variavel para instanciar o dollynho
var ta_no_portao1 = false
var spawn_dollynho = Vector2(107, 590)
var spawn_dollynho_fase1 = Vector2(6500, 590)
var spawn_caminhao_fase1 = Vector2(6500, 690)

# Função chamada quando inicia a fase
func _ready():
	$dollynho.limita_camera(0, 100000, -200, 750)
	$caminhao_dolly.limita_camera(0, 100000, -200, 750)
	$dollynho.gravidade = 0
	$dollynho.position = spawn_dollynho
	$dollynho.pode_pular = true
	$dollynho.forca_pulo = 100
	$Timer.start() # Da um tempinha pra musica começar

func acabou_fase1():
	$dollynho.position = spawn_dollynho_fase1
	$caminhao_dolly.position = spawn_caminhao_fase1

# Toca a musica no começo da fase
func _on_Timer_timeout():
	$musica.play()
	
func _process(delta):
	if ta_no_portao1 and Input.is_action_pressed("ui_e"):
		emit_signal("fase1")

# Função que trata o sinal emitido pelo caminhao quando aperta Q
func _on_caminhao_dolly_saiu_do_caminhao():
	# Desliga o caminhao e instancia um novo dollynho
	$caminhao_dolly.desliga("direita")
	$dollynho.position = Vector2($caminhao_dolly.position.x + 100, $caminhao_dolly.position.y)
	$dollynho.show()
	$dollynho/camera.current = true

# Função pra tratar o sinal emitido pelo caminhao quando o dollynho entra nele
func _on_caminhao_dolly_entrou_no_caminhao():
	# liga o caminhao e mata o dollynho
	$caminhao_dolly.liga("direita", true)
	$dollynho.hide()
	$dollynho.position.y = 0
	$caminhao_dolly/camera.current = true

# Deixa a musica em loop
func _on_musica_finished():
	$musica.play()

# Funções do portao1
func _on_portao1_area_entered(area):
	$portao1/animacao.animation = "abrindo"
	$portao1/animacao.play()
	ta_no_portao1 = true

func _on_portao1_area_exited(area):
	$portao1/animacao.animation = "fechando"
	$portao1/animacao.play()
	ta_no_portao1 = false
