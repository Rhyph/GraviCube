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
	if $AcceptDialog.visible:
		get_tree().paused = true
	else:
		get_tree().paused = false
