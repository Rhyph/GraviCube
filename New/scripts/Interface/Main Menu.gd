extends Control




func _on_Start_pressed():
	G.scene("Tutorial")
func _on_Levels_pressed():
	$ColorRect.visible = true
func _on_Quit_pressed():
	get_tree().quit()

func _on_Tutorial_pressed():
	G.scene("Tutorial")
func _on_Level0_pressed():
	G.scene("Level0")
func _on_Level1_pressed():
	G.scene("Level1")
func _on_Level2_pressed():
	G.scene("Level2")

func _on_Back_pressed():
	$ColorRect.visible = false
