extends StaticBody2D


var once = 0

func _physics_process(delta):
	if once == 0 && $"/root/World/Player".keys == 0:
		once = 1
		$ToOpen.start()
	if once == 2 && $"/root/World/Player".keys == 2:
		once = 0
		$AnimationPlayer.play("closing")

func _on_ToOpen_timeout():
	$AnimationPlayer.play("opening")
	$ToClose.start()

func _on_ToClose_timeout():
	once = 2

func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		$"/root/World/Player".keys = 2
