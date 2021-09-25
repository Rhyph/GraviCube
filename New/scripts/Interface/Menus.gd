extends Control


func _ready():
	visible = true

func _on_Pause_pressed():
	G.UIsound()
	get_tree().paused = true
	$"/root/World/AudioStreamPlayer".volume_db = -10
	$"/root/World/Interface/Control/circlebig".visible = false
	$"/root/World/Interface/Control/Node2D".visible = false
	$Pause.disabled = true
	$ColorRect.visible = true

#In-game menu
func _on_Resume_pressed():
	G.UIsound()
	close()
func _on_Checkpoint_pressed():
	G.UIsound()
	close()
	$"/root/World/Player".position = G.PlayerPos
func _on_Restart_pressed():
	G.UIsound()
	close()
	G.Can = false
	G.reload_scene()
func _on_Menu_pressed():
	G.UIsound()
	close()
	G.scene("Main Menu")

func close():
	get_tree().paused = false
	$"/root/World/AudioStreamPlayer".volume_db = -5
	$"/root/World/Interface/Control/circlebig".visible = true
	$"/root/World/Interface/Control/Node2D".visible = true
	$Pause.disabled = false
	$ColorRect.visible = false


#End-level menu
func open2():
	$"/root/World/AudioStreamPlayer".volume_db = -10
	G.Cur_level = max(G.Cur_level, int(G.Level.substr(5)) + 1)
	
	FS.save_data({
		"Current Level" : G.Cur_level,
		"Time scores" : G.Scores_t,
		"Your best" : G.Records_t
	})

func _on_Menu2_pressed():
	G.UIsound()
	close2()
	G.scene("Main Menu")
func _on_Restart2_pressed():
	G.UIsound()
	close2()
	G.Can = false
	G.reload_scene()
func _on_Next2_pressed():
	G.UIsound()
	close2()
	G.zero()

func close2():
	get_tree().paused = false
	$"/root/World/AudioStreamPlayer".volume_db = -5
	$"/root/World/Interface/Control/circlebig".visible = true
	$"/root/World/Interface/Control/Node2D".visible = true
	$Pause.disabled = false
	$ColorRect2.visible = false
	$ColorRect2/Best_time.visible = true

func time():
	if len(G.Records_t) < G.Level_count:
		G.Records_t.append("9:59.99")
		G.Scores_t.append(600)
	$ColorRect2/Time.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	$ColorRect2/Time.visible = true
	var score = 60 * G.Mins + G.Secs
	if score < G.Scores_t[int(G.Level.substr(5))-1]:
		if G.Records_t[int(G.Level.substr(5))-1] != "9:59.99":
			$ColorRect2/Best_time.visible = true
		G.Scores_t[int(G.Level.substr(5))-1] = score
		G.Records_t[int(G.Level.substr(5))-1] = str(G.Mins) + ":" + str(G.Secs)
	elif score != G.Scores_t[int(G.Level.substr(5))-1]:
		$ColorRect2/Record_time.text = "Record: " + G.Records_t[int(G.Level.substr(5))-1]
		$ColorRect2/Record_time.visible = true

func death():
	$ColorRect2/Deaths.text = "Deaths: " + str($"/root/World/Player".deaths)
	$ColorRect2/Deaths.visible = true
func HBox():
	$ColorRect2/HBoxContainer.visible = true
