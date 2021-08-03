extends Control


func _ready():
	visible = true

func _on_Pause_pressed():
	get_tree().paused = true
	$"/root/World/Interface/Control".visible = false
	$Pause.visible = false
	$ColorRect.visible = true

#In-game menu
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
	$"/root/World/Interface/Control".visible = true
	$Pause.visible = true
	$ColorRect.visible = false


#End-level menu
func open2():
	get_tree().paused = true
	
	$ColorRect2/ColorRect2/Time.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	var level_index = int(G.Level.substr(5))
	var score = 60 * G.Mins + G.Secs
	if score < G.Scores_t[level_index]:
		G.Scores_t[level_index] = score
		$ColorRect2/ColorRect2/Best_time.visible = true
		
	$ColorRect2/ColorRect2/Deaths.text = "Deaths: " + str(G.Deaths)
	if G.Deaths < G.Scores_d[level_index]:
		G.Scores_d[level_index] = G.Deaths
		$ColorRect2/ColorRect2/Best_deaths.visible = true
	
	$"/root/World/Interface/Control".visible = false
	$Pause.visible = false
	$"/root/World/Interface/Menus/ColorRect2".visible = true

func _on_Menu2_pressed():
	close2()
	G.zero()
	G.scene("Main Menu")
func _on_Restart2_pressed():
	close2()
	G.Can = false
	G.zero()
	get_tree().reload_current_scene()
func _on_Next2_pressed():
	close2()
	G.zero()
	G.TP = true

func close2():
	get_tree().paused = false
	$"/root/World/Interface/Control".visible = true
	$Pause.visible = true
	$ColorRect2.visible = false
	$ColorRect2/ColorRect2/Best_time.visible = true
	$ColorRect2/ColorRect2/Best_deaths.visible = true
