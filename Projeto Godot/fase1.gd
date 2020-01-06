extends Node2D

var guaranas_coletados = 0
var urso = preload("res://urso.tscn")
var esporte = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$musica.play()
	$dollynho.limita_camera(0, 100000, -1000, 0)
	$gramas/grama8.set_physics_process(false)
	$bola.position = Vector2(845, -140)
	$peixe.set_physics_process(false)
	$dollynho.limita_camera(0, 100000, -1000, 0)
	#$dollynho.position = Vector2(90, -80)
	$dollynho.position = Vector2(6800, -200)
	guaranas_coletados = 7

func _on_gol_body_entered(body):
	$flamengo.play()
	$gramas/grama8.set_physics_process(true)

# Recarrega a cena depois que o dollynho morre
func _on_dollynho_morri():
	get_parent().reinicia()

# Função que deixa a musica em loop
func _on_musica_finished():
	$musica.play()

# Quando o dollynho passa da arvore dos ursos
func _on_ativa_urso_body_entered(body):
	$timer_urso.start()

# Função wue fica gerando os ursos com o tempo
func _on_timer_urso_timeout():
	var ursoi = urso.instance()
	ursoi.position = Vector2(2345,-100)
	add_child(ursoi)
	$timer_urso.start()

# Função chamada qdo entra em algum guarana
func coleta_guarana():
	guaranas_coletados += 1
	$guaranas/Control/lbl.text = String(guaranas_coletados) + "/8"
	if guaranas_coletados == 8:
		remove_child($porta)
	$melhor.play()

# Função de colisão de cada guaraná
func _on_guarana_body_entered(body):
	remove_child($guarana)
	coleta_guarana()
func _on_guarana2_body_entered(body):
	remove_child($guarana2)
	coleta_guarana()
func _on_guarana3_body_entered(body):
	remove_child($guarana3)
	coleta_guarana()
func _on_guarana4_body_entered(body):
	remove_child($guarana4)
	$peixe.set_physics_process(true)
	coleta_guarana()
func _on_guarana5_body_entered(body):
	remove_child($guarana5)
	coleta_guarana()
func _on_guarana6_body_entered(body):
	remove_child($guarana6)
	coleta_guarana()
func _on_guarana7_body_entered(body):
	remove_child($guarana7)
	coleta_guarana()
func _on_guarana8_body_entered(body):
	remove_child($guarana8)
	coleta_guarana()

# Função pra tocar o som qdo ele entra na area do gol
func _on_esporte2_body_entered(body):
	if not esporte:
		$esporte.play()
		esporte = true

# Função pra tocar o som qdo ele entra na area do sol
func _on_Area2D2_body_entered(body):
	$sol.liga()
	$sol/audio_sol.play()

# Quando o urso entra na parede que mata o urso
func _on_Area2D_area_entered(body):
	body.queue_free()

# Dollynho chegou no fim da fase, dispara a rena e o dialogo
func _on_fim_body_entered(body):
	$rena.set_physics_process(true)
	$dollynho.morto = true
	$dollynho/animacao.animation = "parado"

func _on_fim_rena_body_entered(body):
	$rena.set_physics_process(false)
	$dollynho.zoom = true
	$dollynho/camera.drag_margin_right = 0
