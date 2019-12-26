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

# Função chamada a cada frame, processa o movimento
func _physics_process(delta):
	if ligado:
		captura_movimento()
		if lado == 1 and !re:
			$animacao.animation = "direita_andando"
		elif !re:
			$animacao.animation = "esquerda_andando"
		move_and_slide(direcao)

# Função que interpreta os comando do input
func captura_movimento():
	direcao = Vector2()
	var esquerda = Input.is_action_pressed("ui_left")
	var direita = Input.is_action_pressed("ui_right")
	var cima = Input.is_action_pressed("ui_up")
	var baixo = Input.is_action_pressed("ui_down")
	var saiu = Input.is_action_pressed("ui_quit")
	var buzina = Input.is_action_just_pressed("ui_accept")
	# Realiza os comandos
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
		# Emite um sinal pra fase (nó pai)
		emit_signal("saiu_do_caminhao")
	if buzina:
		$buzina.play()

# Liga o caminhão quando o dollynho entra, chamada pela fase
func liga(dir, re_p):
	$som_carro_ligando.play()
	$camera.current = true
	re = re_p
	if dir.casecmp_to("direita"):
		$animacao.animation = "esquerda_andando"
	else:
		$animacao.animation = "direita_andando"

# Desliga quando o dollynho sai
func desliga(dir):
	ligado = false
	# Deixa ele parado do mesmo lado que ele estava
	if dir.casecmp_to("direita"):
		$animacao.animation = "esquerda_parado"
	else:
		$animacao.animation = "direita_parado"

# Só liga quando o som termina
func _on_som_carro_ligando_finished():
	ligado = true
	$animacao.play()

# Detecta o dollynho entrando e avisa a fase
func _on_deteccao_dollynho_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("entrou_no_caminhao")

# Função pra limitar a camera, chamada quando liga o caminhão
func limita_camera(esquerda, direita, cima, baixo):
	$camera.limit_left = esquerda
	$camera.limit_right = direita
	$camera.limit_bottom = baixo
	$camera.limit_top = cima

