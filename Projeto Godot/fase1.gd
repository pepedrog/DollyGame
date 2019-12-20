extends Node2D

# Variaveis da fase
onready var dollynho_scene = preload("res://dollynho.tscn") # Cena do dollynho
var dollynho # variavel para instanciar o dollynho

# Called when the node enters the scene tree for the first time.
func _ready():
	$dollynho.limita_camera(0,1000000, -500, 1000)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Função que trata o sinal emitido pelo caminhao quando aperta Q
func _on_caminhao_dolly_saiu_do_caminhao():
	# Desliga o caminhao e instancia um novo dollynho
	$caminhao_dolly.desliga("direita")
	var new_dollynho = dollynho_scene.instance()
	new_dollynho.limita_camera(0,1000000, -500, 1000)
	new_dollynho.position = Vector2($caminhao_dolly.position.x + 100, $caminhao_dolly.position.y)
	add_child(new_dollynho)

# Função pra tratar o sinal emitido pelo caminhao quando o dollynho entra nele
func _on_caminhao_dolly_entrou_no_caminhao():
	# liga o caminhao e mata o dollynho
	$caminhao_dolly.liga("direita", true)
	remove_child($dollynho)
