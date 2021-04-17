extends CanvasLayer




func _input(event):
	if event is InputEventScreenTouch:
		$AcceptDialog.hide()
		$"/root/World/Interface/circlebig".visible = true

func _Popup():
	$AcceptDialog.popup()

func _physics_process(delta):
	if $AcceptDialog.visible:
		get_tree().paused = true
		$Buttons.visible = false
	else:
		get_tree().paused = false
		$Buttons.visible = true
