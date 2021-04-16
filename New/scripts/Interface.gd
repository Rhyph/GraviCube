extends CanvasLayer




func _Popup():
	$AcceptDialog.popup()

func _physics_process(delta):
	if $AcceptDialog.visible:
		get_tree().paused = true
		$Buttons.visible = false
	else:
		get_tree().paused = false
		$Buttons.visible = true
