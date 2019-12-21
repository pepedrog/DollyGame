extends Node2D

var guaranas_coletados = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$musica.play()
	$dollynho.limita_camera(0, 100000, -1000, 0)
	$gramas/grama8.set_physics_process(false)

func _on_guarana_body_entered(body):
	remove_child($guarana)
	guaranas_coletados += 1

func _on_gol_body_entered(body):
	$flamengo.play()
	$gramas/grama8.set_physics_process(true)
