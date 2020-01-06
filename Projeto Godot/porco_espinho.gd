extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direcao = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x < 1600:
		direcao = 1
		$Sprite.flip_h = false
	elif position.x > 1850:
		direcao = -1
		$Sprite.flip_h = true
	position.x = position.x + direcao * delta * 100
