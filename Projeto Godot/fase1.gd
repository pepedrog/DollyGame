extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$dollynho.limita_camera(0, 100000, -10000, 0)

func _process(delta):
	$dollynho.pode_pular = $dollynho.apoiado or ($dollynho.parede_dir and $dollynho.direcao.x < 0) or ($dollynho.parede_esq and $dollynho.direcao.x > 0)
