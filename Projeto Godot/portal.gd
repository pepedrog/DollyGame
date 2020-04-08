extends Sprite

var girou = false
signal girou
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if girou and scale.x > 0:
		emit_signal("girou")
		scale -= Vector2(0.003, 0.003)
	elif scale.x > 0:
		rotation += 0.04
		scale += Vector2(0.001, 0.001);
		if rotation > 4*PI:
			girou = true
	else:
		set_process(false)
		hide()
