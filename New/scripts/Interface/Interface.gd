extends CanvasLayer




func _ready():
	if G.GraviSwitch == true:
		$circlebig.modulate = Color(1, 1, 1, 1)
		$circlebig.position = Vector2(272, 132)

func _input(event):
	if G.GraviSwitch == true:
		if event is InputEventScreenTouch:
			$AcceptDialog.hide()
			$circlebig.modulate = Color(1, 1, 1, 1)
			$circlebig.position = Vector2(272, 132)

func _Popup():
	$AcceptDialog.popup()

func _physics_process(delta):
	$Labels/Timer.text = "Time: " + str(G.mins) + ":" + str(G.secs)
	$Labels/Death_count.text = "Death count: " + str(G.Deaths)
	$Labels/Keys_count.text = str(-$"/root/World/Player".keys + 2) + "/2"
	if $AcceptDialog.visible:
		get_tree().paused = true
	else:
		get_tree().paused = false
