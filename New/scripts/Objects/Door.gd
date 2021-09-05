extends StaticBody2D


var once = true

func _physics_process(delta):
	if once && $"/root/World/Player".keys == 0:
		$ToOpen.start()
		once = false

func _on_ToOpen_timeout():
	$AnimationPlayer.play("opening")
