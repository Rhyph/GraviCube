extends Control


func _ready():
	if G.Level != "Tutorial 1" || G.Cur_level != 0:
		$VBoxContainer/Start.text = "  Continue"
		$VBoxContainer/Levels.disabled = false
	
	if G.Cur_level > G.Level_count:
		$VBoxContainer/Start.disabled = true
		$VBoxContainer/Start.text = "  No more"
	
	if G.Records_t[0] != "9:59.99":
		$ColorRect/VBoxContainer/Level1/Time1.text = G.Records_t[0]
	if G.Records_t[1] != "9:59.99":
		$ColorRect/VBoxContainer/Level2/Time2.text = G.Records_t[1]
	if G.Records_t[2] != "9:59.99":
		$ColorRect/VBoxContainer/Level3/Time3.text = G.Records_t[2]
	if G.Records_t[3] != "9:59.99":
		$ColorRect/VBoxContainer2/Level4/Time4.text = G.Records_t[3]
	if G.Records_t[4] != "9:59.99":
		$ColorRect/VBoxContainer2/Level5/Time5.text = G.Records_t[4]
	if G.Records_t[5] != "9:59.99":
		$ColorRect/VBoxContainer2/Level6/Time6.text = G.Records_t[5]
	if G.Records_t[6] != "9:59.99":
		$ColorRect/VBoxContainer4/Level7/Time7.text = G.Records_t[6]
	
	if G.Cur_level > 1:
		$ColorRect/VBoxContainer/Level2.disabled = false
		if G.Cur_level > 2:
			$ColorRect/VBoxContainer/Level3.disabled = false
			if G.Cur_level > 3:
				world2()
				if G.Cur_level > 4:
					$ColorRect/VBoxContainer2/Level5.disabled = false
					if G.Cur_level > 5:
						$ColorRect/VBoxContainer2/Level6.disabled = false
						if G.Cur_level > 6:
							world()
							world3()

func _on_Start_pressed():
	G.UIsound()
	if G.Cur_level == 0:
		G.scene(str(G.Level))
	else:
		G.scene("Level " + str(G.Cur_level))

func _on_Levels_pressed():
	G.UIsound()
	$ColorRect.visible = true
func _on_Quit_pressed():
	G.UIsound()
	get_tree().quit()

func _on_Back_pressed():
	G.UIsound()
	$ColorRect.visible = false
func _on_PrevWorld_pressed():
	G.UIsound()
	world()
	if $ColorRect/World.text == "World 3":
		world2()
	elif $ColorRect/World.text == "World 2":
		world1()
	else:
		world0()
func _on_NextWorld_pressed():
	G.UIsound()
	world()
	if $ColorRect/World.text == "Tutorials":
		world1()
	elif $ColorRect/World.text == "World 1":
		world2()
	else:
		world3()

func _on_Level01_pressed():
	G.UIsound()
	G.scene("Tutorial 1")
func _on_Level02_pressed():
	G.UIsound()
	G.scene("Tutorial 2")
func _on_Level03_pressed():
	G.UIsound()
	G.scene("Tutorial 3")
func _on_Level1_pressed():
	G.UIsound()
	G.scene("Level 1")
func _on_Level2_pressed():
	G.UIsound()
	G.scene("Level 2")
func _on_Level3_pressed():
	G.UIsound()
	G.scene("Level 3")
func _on_Level4_pressed():
	G.UIsound()
	G.scene("Level 4")
func _on_Level5_pressed():
	G.UIsound()
	G.scene("Level 5")
func _on_Level6_pressed():
	G.UIsound()
	G.scene("Level 6")
func _on_Level7_pressed():
	G.UIsound()
	G.scene("Level 7")

func world():
	$ColorRect/VBoxContainer3.visible = false
	$ColorRect/VBoxContainer.visible = false
	$ColorRect/VBoxContainer2.visible = false
	$ColorRect/VBoxContainer4.visible = false
func world0():
	$ColorRect/World.text = "Tutorials"
	$ColorRect/VBoxContainer3.visible = true
	$ColorRect/PrevWorld.visible = false
func world1():
	$ColorRect/World.text = "World 1"
	$ColorRect/VBoxContainer.visible = true
	$ColorRect/NextWorld.visible = true
	$ColorRect/PrevWorld.visible = true
func world2():
	$ColorRect/World.text = "World 2"
	$ColorRect/VBoxContainer2.visible = true
	$ColorRect/NextWorld.visible = true
	$ColorRect/PrevWorld.visible = true
func world3():
	$ColorRect/World.text = "World 3"
	$ColorRect/VBoxContainer4.visible = true
	$ColorRect/NextWorld.visible = false
