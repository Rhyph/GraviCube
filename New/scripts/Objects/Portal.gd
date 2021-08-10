extends Area2D


export var next_scene: PackedScene

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		$"/root/World/Interface/Menus/ColorRect2".visible = true
		$"/root/World/Interface/Menus/AnimationPlayer".play("idle")
		$"/root/World/Interface/Control".visible = false
		$"/root/World/Interface/Menus/Pause".visible = false
		$Timer.start()

func _on_Timer_timeout():
	G.Can = false
	$"/root/World/Interface/Menus".open2()

func _physics_process(delta):
	if G.TP:
		$Transition.start()
		G.TP = false

func _on_Transition_timeout():
	G.PlayerPos = Vector2(4, -4)
	$"/root/World/Interface/Menus".close2()
	get_tree().change_scene_to(next_scene)
