extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pulo = 150
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if pulo < -150:
		pulo = 150
	move_and_slide(Vector2(-100,-pulo))
	pulo -= 10
