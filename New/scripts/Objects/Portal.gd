extends Area2D


export var next_scene: PackedScene

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		G.Can = false
		$AnimationPlayer.play("Fade_in")
		yield($AnimationPlayer,"animation_finished")
		$"/root/World/Interface/Menus".open2()

func _physics_process(delta):
	if G.TP:
		G.PlayerPos = Vector2(4, -4)
		get_tree().change_scene_to(next_scene)
		G.TP = false
