extends KinematicBody2D

signal entrou_no_dollycoptero
signal saiu_do_dollycoptero

# Variáveis do caminhão
var direcao = Vector2()
var velocidade = 400
var velocidade_vertical = 100
var lado # 1 = direita, -1 = esquerda
var ligado = false

# Função chamada a cada frame, processa o movimento
func _physics_process(delta):
	if ligado:
		captura_movimento()
		if lado == -1:
			$animacao.flip_h = false
		else:
			$animacao.flip_h = true
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
		emit_signal("saiu_do_dollycoptero")
	if buzina:
		$buzina.play()

# Liga o caminhão quando o dollynho entra, chamada pela fase
func liga(dir):
	$som_helicoptero.play()
	$camera.current = true
	if dir.casecmp_to("direita"):
		$animacao.flip_h = false
	else:
		$animacao.flip_h = true
	$animacao.play()
	ligado = true

# Desliga quando o dollynho sai
func desliga(dir):
	ligado = false
	# Deixa ele parado do mesmo lado que ele estava
	if dir.casecmp_to("direita"):
		$animacao.flip_h = false
	else:
		$animacao.flip_h = true
	$animacao.stop()

# Detecta o dollynho entrando e avisa a fase
func _on_deteccao_dollynho_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("entrou_no_dollycoptero")

# Função pra limitar a camera, chamada quando liga o caminhão
func limita_camera(esquerda, direita, cima, baixo):
	$camera.limit_left = esquerda
	$camera.limit_right = direita
	$camera.limit_bottom = baixo
	$camera.limit_top = cima

# Código pra por na fase
#
## Função que trata o sinal emitido pelo dollycoptero quando aperta Q
#func _on_dollycoptero_saiu_do_dollycoptero():
#	# Desliga o caminhao e instancia um novo dollynho
#	$caminhao_dolly.desliga("direita")
#	dollynho = dollynho_scene.instance()
#	add_dollynho(Vector2($dollycoptero.position.x + 100, $dollycoptero.position.y))
#
## Função pra tratar o sinal emitido pelo dollycoptero quando o dollynho entra nele
#func _on_dollycoptero_entrou_no_dollycoptero():
#	# liga o dollycoptero e mata o dollynho
#	$dollycoptero.liga("direita")
#	$dollycoptero.limita_camera(0, 100000, -1000, 0)
#	remove_child($dollynho)
