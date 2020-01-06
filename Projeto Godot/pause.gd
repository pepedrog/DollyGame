extends Control

# Captura o input
func _input(event):
	# Tecla p ou esq -> pausa
	if event.is_action_pressed("ui_pause"):
		get_tree().paused = not get_tree().paused
		visible = not visible
	# Se já esta pausado, captura a interação do usuario
	elif get_tree().paused:
		# Tecla pra baixo -> Atualiza os dollynhos
		if event.is_action_pressed("ui_down"):
			if $continuar/tr.visible:
				$continuar/tr.visible = false
				$reiniciar/tr.visible = true
			elif $reiniciar/tr.visible == true:
				$reiniciar/tr.visible = false
				$init/tr.visible = true
			elif $init/tr.visible == true:
				$init/tr.visible = false
				$sair/tr.visible = true
		# Tecla pra cima -> Atualiza os dollynhos
		elif event.is_action_pressed("ui_up"):
			if $sair/tr.visible:
				$sair/tr.visible = false
				$init/tr.visible = true
			elif $init/tr.visible == true:
				$init/tr.visible = false
				$reiniciar/tr.visible = true
			elif $reiniciar/tr.visible == true:
				$reiniciar/tr.visible = false
				$continuar/tr.visible = true
		
		# Tecla enter -> Realiza o botão
		elif event.is_action_pressed("ui_accept"):
			if $reiniciar/tr.visible:
				# Chama o metodo reinicia da cena raiz
				get_parent().get_parent().reinicia()
			elif $init/tr.visible:
				# Chama o metodo tela_inicial da cena raiz
				get_parent().get_parent().tela_inicial()
			elif $sair/tr.visible:
				get_tree().quit()
			despausa()

func despausa():
	get_tree().paused = not get_tree().paused
	visible = not visible
	