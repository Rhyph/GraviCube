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
	G.reload_scene()
func _on_Menu_pressed():
	close()
	G.scene("Main Menu")

func close():
	get_tree().paused = false
	$"/root/World/Interface/Control".visible = true
	$Pause.visible = true
	$ColorRect.visible = false


#End-level menu
func open2():
	get_tree().paused = true
	
	G.Cur_level = max(G.Cur_level, int(G.Level.substr(5)) + 1)
	
	$ColorRect2/Time.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	var level_index = int(G.Level.substr(5))
	var score = 60 * G.Mins + G.Secs
	if score < G.Scores_t[level_index]:
		G.Scores_t[level_index] = score
		G.Records_t[level_index] = str(G.Mins) + ":" + str(G.Secs)
		$ColorRect2/Best_time.visible = true
	elif score != G.Scores_t[level_index]:
		$ColorRect2/Record_time.text = "Your best: " + G.Records_t[level_index]
		$ColorRect2/Record_time.visible = true
	
	$ColorRect2/Deaths.text = "Deaths: " + str(G.Deaths)
	if G.Deaths < G.Scores_d[level_index]:
		G.Scores_d[level_index] = G.Deaths
		$ColorRect2/Best_deaths.visible = true
	elif G.Deaths != G.Scores_d[level_index]:
		$ColorRect2/Record_deaths.text = "Your best: " + str(G.Scores_d[level_index])
		$ColorRect2/Record_deaths.visible = true
	
	FS.save_data({
		"Current Level" : G.Cur_level,
		"Death scores" : G.Scores_d,
		"Time scores" : G.Scores_t,
		"Your best" : G.Records_t
	})
	
	$"/root/World/Interface/Control".visible = false
	$Pause.visible = false
	$"/root/World/Interface/Menus/ColorRect2".visible = true

func _on_Menu2_pressed():
	close2()
	G.scene("Main Menu")
func _on_Restart2_pressed():
	close2()
	G.Can = false
	G.reload_scene()
func _on_Next2_pressed():
	get_tree().paused = false
	$ColorRect2.visible = false
	G.zero()
	G.TP = true

func close2():
	get_tree().paused = false
	$"/root/World/Interface/Control".visible = true
	$Pause.visible = true
	$ColorRect2.visible = false
	$ColorRect2/Best_time.visible = true
	$ColorRect2/Best_deaths.visible = true

var Resume_t
var Checkpoint_t
var Restart_t
var Menu_t
func _on_Resume_mouse_entered():
	Resume_t = $ColorRect/VBoxContainer/Resume.text
	$ColorRect/VBoxContainer/Resume.text = " " + Resume_t
func _on_Resume_mouse_exited():
	$ColorRect/VBoxContainer/Resume.text = Resume_t
func _on_Checkpoint_mouse_entered():
	Checkpoint_t = $ColorRect/VBoxContainer/Checkpoint.text
	$ColorRect/VBoxContainer/Checkpoint.text = " " + Checkpoint_t
func _on_Checkpoint_mouse_exited():
	$ColorRect/VBoxContainer/Checkpoint.text = Checkpoint_t
func _on_Restart_mouse_entered():
	Restart_t = $ColorRect/VBoxContainer/Restart.text
	$ColorRect/VBoxContainer/Restart.text = " " + Restart_t
func _on_Restart_mouse_exited():
	$ColorRect/VBoxContainer/Restart.text = Restart_t
func _on_Menu_mouse_entered():
	Menu_t = $ColorRect/VBoxContainer/Menu.text
	$ColorRect/VBoxContainer/Menu.text = " " + Menu_t
func _on_Menu_mouse_exited():
	$ColorRect/VBoxContainer/Menu.text = Menu_t
func _on_Menu2_mouse_entered():
	$ColorRect2/HBoxContainer/Menu2.rect_size.x = 68
func _on_Menu2_mouse_exited():
	$ColorRect2/HBoxContainer/Menu2.rect_size.x = 63
func _on_Restart2_mouse_entered():
	$ColorRect2/HBoxContainer/Restart2.rect_size.x = 64
func _on_Restart2_mouse_exited():
	$ColorRect2/HBoxContainer/Restart2.rect_size.x = 59
func _on_Next2_mouse_entered():
	$ColorRect2/HBoxContainer/Next2.rect_size.x = 77
func _on_Next2_mouse_exited():
	$ColorRect2/HBoxContainer/Next2.rect_size.x = 72
