extends Area2D




func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		G.can = false
		$AnimationPlayer.play("Fade_in")
		yield($AnimationPlayer,"animation_finished")
		G.PlayerPos = Vector2(4, -4)
		get_tree().change_scene("res://scenes/levels/World.tscn")
