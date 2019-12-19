extends KinematicBody2D

signal entrou_no_caminhao

# variaveis do dollynho
var tamanho_tela

var direcao = Vector2() # vetor bidimensional (x,y) da direção do movimento
var velocidade = 200 # velocidade do movimento horizontal
var gravidade = 10 # aceleração da gravidade
var forca_pulo = 400 # aceleração inicial do pulo
var delta_pulo = 20  # quantidade de iterações que dura um pulo
# Depois de umas continhas chatas descobri que se quiser que a decida e a subida
# do pulo durem o mesmo tempo, é preciso que (forca_pulo = gravidade * delta_pulo)
var tempo_pulo = 1 # variavel de controle do pulo (indica a intensidade também) 
var pulando = false # variavel que indica se está em um pulo
var pode_pular = true # variavel que indica se pode pular

# Função chamada quando o dollynho é instanciado
func _ready():
	pass

# Função chamada constantemente, "loop principal" do jogo
func _physics_process(delta):
	# Pega o tamanho da tela
	tamanho_tela = get_viewport_rect().size
	captura_movimento()
	roda_animacao()
	# Anda o dollynho (atualiza a posição)
	var colisao = move_and_collide(direcao * delta)
	if colisao:
		direcao.y = 0
		if colisao.collider.has_method("liga"):
			emit_signal("entrou_no_caminhao")

# Função que verifica se alguma tecla de andar foi apertada e atualiza a direção
func captura_movimento():
	#pega a tecla apertada do input
	var esquerda = Input.is_action_pressed("ui_left")
	var direita = Input.is_action_pressed("ui_right")
	var cima = Input.is_action_pressed("ui_up")
	
	# movimento horizontal
	if esquerda:
		direcao.x = - velocidade
	elif direita:
		direcao.x = velocidade
	else:
		direcao.x = 0
	
	# possível pulo
	var novo_pulo = false
	if cima and pode_pular:
		pulando = true
		novo_pulo = true
	# executa ou termina de executar o pulo
	if pulando:
		# se novo pulo, reseta o tempo
		if novo_pulo:
			tempo_pulo = 1
		# se esta no meio do pulo, atualiza a direção
		if tempo_pulo > 0:
			# A intensidade do pulo varia com o tempo (aceleração)
			direcao.y = - tempo_pulo * forca_pulo 
		# se acabou o pulo, reseta
		else:
			tempo_pulo = 1
			pulando = false
		# atualiza o tempo do pulo
		tempo_pulo -= float(1) / delta_pulo
	else:
		direcao.y += gravidade

# Escolhe a animação (sprite) com base na direção do movimento
func roda_animacao():
	if direcao.x != 0:
		$animacao.animation = "direita"
	else:
		$animacao.animation = "parado"
	$animacao.flip_h = direcao.x < 0
	$animacao.play()

func _on_dollynho_input_event(viewport, event, shape_idx):
	print(viewport, event, shape_idx)
