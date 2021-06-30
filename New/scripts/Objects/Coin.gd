extends Area2D



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		$AnimationPlayer.play("picked")
		$"/root/World/Interface/coin".visible = true
