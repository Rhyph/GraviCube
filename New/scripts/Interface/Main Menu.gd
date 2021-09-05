extends Control


func _ready():
	if G.Cur_level != 1:
		$VBoxContainer/Start.text = "  Continue"
		$VBoxContainer/Levels.disabled = false
	if G.Cur_level > 1:
		$ColorRect/VBoxContainer2/Level2.disabled = false
	if G.Cur_level > 2:
		$ColorRect/VBoxContainer2/Level3.disabled = false
	if G.Cur_level > 3:
		$ColorRect/VBoxContainer2/Level4.disabled = false
	if G.Cur_level > 4:
		$ColorRect/VBoxContainer2/Level5.disabled = false
	if G.Cur_level > 5:
		$VBoxContainer/Start.text = "  New game"
		$VBoxContainer/Start.disabled = true

func _on_Start_pressed():
	G.scene("Level" + str(G.Cur_level))
func _on_Levels_pressed():
	$ColorRect.visible = true
func _on_Quit_pressed():
	get_tree().quit()

func _on_Back_pressed():
	$ColorRect.visible = false

func _on_Level0_pressed():
	G.scene("Level1")
func _on_Level1_pressed():
	G.scene("Level2")
func _on_Level2_pressed():
	G.scene("Level3")
func _on_Level4_pressed():
	G.scene("Level4")
func _on_Level5_pressed():
	G.scene("Level5")
