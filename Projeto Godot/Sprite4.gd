extends Sprite

signal girou
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += 0.1
	scale += Vector2(1,1);
	if rotation > 6.29:
		emit_signal("girou")
