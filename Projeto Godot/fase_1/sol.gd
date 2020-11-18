extends StaticBody2D

var fogo = preload("res://fase_1/bola_fogo.tscn")

func liga():
	$timer_sol.start()

# Função que gera uma bola de fogo qdo o timer acaba
func _on_timer_sol_timeout():
	$Path2D/PathFollow2D.set_offset(randi())
	var f = fogo.instance()
	add_child(f)
	var direction = $Path2D/PathFollow2D.rotation + PI / 2
	f.position = $Path2D/PathFollow2D.position
	direction += rand_range(-PI / 4, PI / 4)
	f.rotation = direction
	f.linear_velocity = Vector2(rand_range(1, 500), 0)
	f.linear_velocity = f.linear_velocity.rotated(direction)
