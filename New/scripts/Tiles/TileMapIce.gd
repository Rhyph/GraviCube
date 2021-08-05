extends StaticBody2D




var switch = true

func _Laser():
	if switch:
		switch = false
		set_collision_layer(3)
		$AnimationPlayer.play("Laser")
