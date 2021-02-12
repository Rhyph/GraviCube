extends CanvasLayer




func _Popup():
	$AcceptDialog.popup()

func _physics_process(delta):
	if $AcceptDialog.visible:
		get_tree().paused = true
	else:
		get_tree().paused = false
