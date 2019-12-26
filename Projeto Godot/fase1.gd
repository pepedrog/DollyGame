extends Node2D

var guaranas_coletados = 0
var spawn = Vector2(125, -80)
var urso = preload("res://urso.tscn")
var esporte = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$musica.play()
	$dollynho.limita_camera(0, 100000, -1000, 0)
	$gramas/grama8.set_physics_process(false)
	$bola.position = Vector2(845, -140)
	$peixe.set_physics_process(false)

func _on_gol_body_entered(body):
	$flamengo.play()
	$gramas/grama8.set_physics_process(true)

func atingido(body):
	if body.has_method("morre"):
		body.morre()

func _on_dollynho_morri():
	get_tree().change_scene("res://fase1.tscn")

func _on_Area2D_body_entered(body):
	$peixe.set_physics_process(true)

func _on_musica_finished():
	$musica.play()

func _on_ativa_urso_body_entered(body):
	$timer_urso.start()

func _on_timer_urso_timeout():
	var ursoi = urso.instance()
	ursoi.position = Vector2(2345,-100)
	ursoi.connect("body_entered", self, "atingido")
	add_child(ursoi)
	$timer_urso.start()

func _on_mata_urso_area_entered(area):
	area.queue_free()

func _on_guarana_body_entered(body):
	remove_child($guarana)
	guaranas_coletados += 1

func _on_guarana2_body_entered(body):
	remove_child($guarana2)
	guaranas_coletados += 1

func _on_guarana3_body_entered(body):
	remove_child($guarana3)
	guaranas_coletados += 1

func _on_guarana4_body_entered(body):
	remove_child($guarana4)
	guaranas_coletados += 1

func _on_guarana5_body_entered(body):
	remove_child($guarana5)
	guaranas_coletados += 1

func _on_guarana6_body_entered(body):
	remove_child($guarana6)
	guaranas_coletados += 1

func _on_guarana7_body_entered(body):
	remove_child($guarana7)
	guaranas_coletados += 1

func _on_esporte2_body_entered(body):
	if not esporte:
		$esporte.play()
		esporte = true
