extends CanvasLayer


var secs = 0.0
var mins = 0

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
	$Time.text = "Time: " + str(mins) + ":" + str(secs)
	$Death_count.text = "Death count: " + str(G.Deaths)
	if $AcceptDialog.visible:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _on_Timer_timeout():
	secs += .01
	if secs >= 60.0:
		secs = 0
		mins += 1
