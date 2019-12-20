extends KinematicBody2D

signal entrou_no_caminhao
signal saiu_do_caminhao

# Variáveis do caminhão
var direcao = Vector2()
var velocidade = 400
var velocidade_vertical = 100
var lado # 1 = direita, -1 = esquerda
var re = false
var ligado = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if ligado:
		captura_movimento()
		if lado == 1 and !re:
			$animacao.animation = "direita_andando"
		elif !re:
			$animacao.animation = "esquerda_andando"
		move_and_slide(direcao)
		
func captura_movimento():
	direcao = Vector2()
	var esquerda = Input.is_action_pressed("ui_left")
	var direita = Input.is_action_pressed("ui_right")
	var cima = Input.is_action_pressed("ui_up")
	var baixo = Input.is_action_pressed("ui_down")
	var saiu = Input.is_action_pressed("ui_quit")
	if esquerda:
		lado = -1
		direcao.x = - velocidade
	elif direita:
		lado = 1
		direcao.x = velocidade
	if cima:
		direcao.y = - velocidade_vertical
	elif baixo:
		direcao.y = velocidade_vertical
	if saiu:
		emit_signal("saiu_do_caminhao")

func liga(dir, re_p):
	$som_carro_ligando.play()
	$camera.current = true
	re = re_p
	if dir.casecmp_to("direita"):
		$animacao.animation = "esquerda_andando"
	else:
		$animacao.animation = "direita_andando"

func desliga(dir):
	ligado = false
	if dir.casecmp_to("direita"):
		$animacao.animation = "esquerda_parado"
	else:
		$animacao.animation = "direita_parado"

func _on_som_carro_ligando_finished():
	ligado = true
	$animacao.play()

func _on_deteccao_dollynho_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("entrou_no_caminhao")
