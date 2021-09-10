extends Control


func _ready():
	if G.Records_t[0] != "9:59.99":
		$ColorRect/VBoxContainer2/Level1/Time1.text = G.Records_t[0]
	if G.Records_t[1] != "9:59.99":
		$ColorRect/VBoxContainer2/Level2/Time2.text = G.Records_t[1]
	if G.Records_t[2] != "9:59.99":
		$ColorRect/VBoxContainer2/Level3/Time3.text = G.Records_t[2]
	if G.Records_t[3] != "9:59.99":
		$ColorRect/VBoxContainer2/Level4/Time4.text = G.Records_t[3]
	if G.Records_t[4] != "9:59.99":
		$ColorRect/VBoxContainer2/Level5/Time5.text = G.Records_t[4]
	if G.Records_t[5] != "9:59.99":
		$ColorRect/VBoxContainer2/Level6/Time6.text = G.Records_t[5]
	
	if len(G.Records_t) < G.Level_count:
		G.Records_t.append("9:59.99")
		G.Scores_t.append(600)
	
	if G.Cur_level > 1:
		$ColorRect/VBoxContainer2/Level2.disabled = false
		$VBoxContainer/Start.text = "  Continue"
		$VBoxContainer/Levels.disabled = false
	if G.Cur_level > 2:
		$ColorRect/VBoxContainer2/Level3.disabled = false
	if G.Cur_level > 3:
		$ColorRect/VBoxContainer2/Level4.disabled = false
	if G.Cur_level > 4:
		$ColorRect/VBoxContainer2/Level5.disabled = false
	if G.Cur_level > 5:
		$ColorRect/VBoxContainer2/Level6.disabled = false
	if G.Cur_level > 6:
		$VBoxContainer/Start.text = "  New game"
		$VBoxContainer/Start.disabled = true

func _on_Start_pressed():
	G.UIsound()
	G.scene("Level" + str(G.Cur_level))
func _on_Levels_pressed():
	G.UIsound()
	$ColorRect.visible = true
func _on_Quit_pressed():
	G.UIsound()
	get_tree().quit()

func _on_Back_pressed():
	G.UIsound()
	$ColorRect.visible = false

func _on_Level0_pressed():
	G.UIsound()
	G.scene("Level1")
func _on_Level1_pressed():
	G.UIsound()
	G.scene("Level2")
func _on_Level2_pressed():
	G.UIsound()
	G.scene("Level3")
func _on_Level4_pressed():
	G.UIsound()
	G.scene("Level4")
func _on_Level5_pressed():
	G.UIsound()
	G.scene("Level5")
func _on_Level6_pressed():
	G.UIsound()
	G.scene("Level6")
