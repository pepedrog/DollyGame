extends StaticBody2D

# Declare member variables here. Examples:
var direcao = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (position.x < 1000):
		direcao = 1
	if (position.x > 1330):
		direcao = -1
	position.x = (position.x + direcao * delta * 150) 
