extends Node2D

# Variaveis da fase
onready var dollynho_scene = preload("res://dollynho.tscn") # Cena do dollynho
var dollynho # variavel para instanciar o dollynho
var ta_no_portao1 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	dollynho = $dollynho
	add_dollynho(107, 594)
	$Timer.start()

func _process(delta):
	if ta_no_portao1 and Input.is_action_pressed("ui_e"):
		get_tree().change_scene("res://fase1.tscn")

func add_dollynho(x, y):
	dollynho.limita_camera(0, 100000, -200, 750)
	dollynho.gravidade = 0
	dollynho.position = Vector2(x, y)
	dollynho.pode_pular = true
	dollynho.forca_pulo = 100
	add_child(dollynho)

# Função que trata o sinal emitido pelo caminhao quando aperta Q
func _on_caminhao_dolly_saiu_do_caminhao():
	# Desliga o caminhao e instancia um novo dollynho
	$caminhao_dolly.desliga("direita")
	dollynho = dollynho_scene.instance()
	add_dollynho($caminhao_dolly.position.x + 100, $caminhao_dolly.position.y)

# Função pra tratar o sinal emitido pelo caminhao quando o dollynho entra nele
func _on_caminhao_dolly_entrou_no_caminhao():
	# liga o caminhao e mata o dollynho
	$caminhao_dolly.liga("direita", true)
	$caminhao_dolly.limita_camera(0, 100000, -200, 750)
	remove_child($dollynho)

func _on_musica_finished():
	$musica.play()

func _on_Timer_timeout():
	$musica.play()

func _on_portao1_area_entered(area):
	$portao1/animacao.animation = "abrindo"
	$portao1/animacao.play()
	ta_no_portao1 = true

func _on_portao1_area_exited(area):
	$portao1/animacao.animation = "fechando"
	$portao1/animacao.play()
	ta_no_portao1 = false
