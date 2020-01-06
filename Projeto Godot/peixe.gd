extends StaticBody2D

# Variaveis do peixe
var baixo
var subindo = true
var gravidade = 10 # aceleração da gravidade
var forca_pulo = 800 # aceleração inicial do pulo
var delta_pulo = 20  # quantidade de iterações que dura um pulo
var tempo_pulo = 1
var intensidade = 0

func _ready():
	baixo = position.y

# Processa o pulo do peixe, copiado do pulo do dollynho
func _physics_process(delta):
	if position.y > baixo:
		subindo = true
	# executa ou termina de executar o pulo
	if subindo:
		$Sprite.flip_v = true
		# se esta no meio do pulo, atualiza a direção
		if tempo_pulo > 0:
			# A intensidade do pulo varia com o tempo (aceleração)
			intensidade = - tempo_pulo * forca_pulo
			# atualiza o tempo do pulo
			tempo_pulo -= float(1) / delta_pulo
			# se acabou o pulo, reseta
		else:
			tempo_pulo = 1
			subindo = false
	# Aqui troquei o else, porque quando o pulo acaba é importante ja botar a gravidade
	if not subindo:
		$Sprite.flip_v = false
		intensidade += gravidade
	position.y += intensidade * delta