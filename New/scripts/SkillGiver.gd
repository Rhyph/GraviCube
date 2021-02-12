extends Area2D




func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		$AnimationPlayer.play("pick")

func _Picked():
	G.GraviSwitch = true
	$"/root/World/Interface"._Popup()
