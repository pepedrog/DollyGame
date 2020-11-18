extends Node2D

var balao = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if balao == 6:
			get_parent().emit_signal("acabou")
		else:
			balao += 1
			get_node("balao" + String(balao)).show()
			get_node("balao" + String(balao - 1)).hide()
