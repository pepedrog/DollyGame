extends KinematicBody2D

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
# variáveis para controlar o double jump
var pulando = 0 # variavel que indica se está em um pulo: 0 = não, > 0 = pulo pra direita, < 0 = esquerda
var pode_pular = true # variavel que indica se pode pular
var parede_dir = false
var parede_esq = false
var apoiado = false

# Função chamada quando o dollynho é instanciado
func _ready():
	$camera.current = true

# Função chamada constantemente, "loop principal" do jogo
func _physics_process(delta):
	# Pega o tamanho da tela
	tamanho_tela = get_viewport_rect().size
	captura_movimento()
	roda_animacao()
	# Anda o dollynho (atualiza a posição)
	var dir_slide = move_and_slide(direcao)
	# se o vetor mudou depois do movimento
	apoiado = dir_slide.y < direcao.y
	parede_dir = dir_slide.x < direcao.x
	parede_esq = dir_slide.x > direcao.x
	direcao = dir_slide

# Função que verifica se alguma tecla de andar foi apertada e atualiza a direção
func captura_movimento():
	#pega a tecla apertada do input
	var esquerda = Input.is_action_pressed("ui_left")
	var direita = Input.is_action_pressed("ui_right")
	var cima = Input.is_action_pressed("ui_up")
	var baixo = Input.is_action_pressed("ui_down")
	# movimento horizontal
	if esquerda:
		direcao.x = - velocidade
	elif direita:
		direcao.x = velocidade
	else:
		direcao.x = 0
	
	# possível pulo
	# wall_jump
	var novo_pulo = false
	if cima and (direita and parede_esq) or (esquerda and parede_dir):
		pode_pular = true
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
			# atualiza o tempo do pulo
			tempo_pulo -= float(1) / delta_pulo
			# se acabou o pulo, reseta
		else:
			tempo_pulo = 1
			pulando = false
	# Aqui troquei o else, porque quando o pulo acaba é importante ja botar a gravidade
	if not pulando:
		direcao.y += gravidade
	
	# Para regioes especiais
	if gravidade == 0:
		if baixo:
			direcao.y = forca_pulo
		elif cima:
			direcao.y = - forca_pulo
		else:
			direcao.y = 0
# Escolhe a animação (sprite) com base na direção do movimento
func roda_animacao():
	if direcao.x != 0:
		$animacao.animation = "direita"
	else:
		$animacao.animation = "parado"
	$animacao.flip_h = direcao.x < 0
	$animacao.play()

func limita_camera(esquerda, direita, cima, baixo):
	$camera.limit_left = esquerda
	$camera.limit_right = direita
	$camera.limit_bottom = baixo
	$camera.limit_top = cima