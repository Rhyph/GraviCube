extends Control




func _on_Pause_pressed():
	get_tree().paused = true
	$ColorRect.visible = true

func _on_Resume_pressed():
	close()
func _on_Checkpoint_pressed():
	close()
	$"/root/World/Player".position = G.PlayerPos
func _on_Restart_pressed():
	close()
	G.Can = false
	get_tree().reload_current_scene()
	G.zero()
func _on_Menu_pressed():
	close()
	G.scene("Main Menu")
	G.zero()

func close():
	get_tree().paused = false
	$ColorRect.visible = false
