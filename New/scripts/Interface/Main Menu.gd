extends Control


func _ready():
	if G.Cur_level != 0:
		$VBoxContainer/Start.text = "Continue"
	
	if G.Cur_level > 0:
		$ColorRect/VBoxContainer2/Level1.disabled = false
	if G.Cur_level > 1:
		$ColorRect/VBoxContainer2/Level2.disabled = false
	if G.Cur_level > 2:
		$ColorRect/VBoxContainer2/Level3.disabled = false

func _on_Start_pressed():
	G.scene("Level" + str(G.Cur_level))
func _on_Levels_pressed():
	$ColorRect.visible = true
func _on_Quit_pressed():
	FS.save_data({
		"Current Level" : G.Cur_level,
		"Death scores" : G.Scores_d,
		"Time scores" : G.Scores_t
	})
	get_tree().quit()

func _on_Tutorial_pressed():
	G.scene("Level0")
func _on_Level0_pressed():
	G.scene("Level1")
func _on_Level1_pressed():
	G.scene("Level2")
func _on_Level2_pressed():
	G.scene("Level3")

func _on_Back_pressed():
	$ColorRect.visible = false
