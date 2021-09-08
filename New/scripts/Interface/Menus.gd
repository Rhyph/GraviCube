extends Control


func _ready():
	visible = true

func _on_Pause_pressed():
	get_tree().paused = true
	$"/root/World/AudioStreamPlayer".volume_db = -10
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
	G.reload_scene()
func _on_Menu_pressed():
	close()
	G.scene("Main Menu")

func close():
	get_tree().paused = false
	$"/root/World/AudioStreamPlayer".volume_db = -5
	$"/root/World/Interface/Control".visible = true
	$Pause.visible = true
	$ColorRect.visible = false


#End-level menu
func open2():
	$"/root/World/AudioStreamPlayer".volume_db = -10
	G.Cur_level = max(G.Cur_level, int(G.Level.substr(5)) + 1)
	
	FS.save_data({
		"Current Level" : G.Cur_level,
		"Death scores" : G.Scores_d,
		"Time scores" : G.Scores_t,
		"Your best" : G.Records_t
	})

func _on_Menu2_pressed():
	close2()
	G.scene("Main Menu")
func _on_Restart2_pressed():
	close2()
	G.Can = false
	G.reload_scene()
func _on_Next2_pressed():
	close2()
	G.zero()

func close2():
	get_tree().paused = false
	$"/root/World/AudioStreamPlayer".volume_db = -5
	$"/root/World/Interface/Control".visible = true
	$Pause.visible = true
	$ColorRect2.visible = false
	$ColorRect2/Best_time.visible = true
	$ColorRect2/Best_deaths.visible = true

func time():
	$ColorRect2/Time.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	$ColorRect2/Time.visible = true
	var score = 60 * G.Mins + G.Secs
	if score < G.Scores_t[int(G.Level.substr(5))-1]:
		G.Scores_t[int(G.Level.substr(5))-1] = score
		G.Records_t[int(G.Level.substr(5))-1] = str(G.Mins) + ":" + str(G.Secs)
		$ColorRect2/Best_time.visible = true
	elif score != G.Scores_t[int(G.Level.substr(5))-1]:
		$ColorRect2/Record_time.text = "Your best: " + G.Records_t[int(G.Level.substr(5))-1]
		$ColorRect2/Record_time.visible = true

func death():
	$ColorRect2/Deaths.text = "Deaths: " + str(G.Deaths)
	$ColorRect2/Deaths.visible = true
	if G.Deaths < G.Scores_d[int(G.Level.substr(5))-1]:
		G.Scores_d[int(G.Level.substr(5))-1] = G.Deaths
		$ColorRect2/Best_deaths.visible = true
	elif G.Deaths != G.Scores_d[int(G.Level.substr(5))-1]:
		$ColorRect2/Record_deaths.text = "Your best: " + str(G.Scores_d[int(G.Level.substr(5))-1])
		$ColorRect2/Record_deaths.visible = true

func HBox():
	$ColorRect2/HBoxContainer.visible = true
