extends StaticBody2D




func _physics_process(delta):
	if G.Laved:
		if $lavaBlock.modulate.r < 2:
			$lavaBlock.modulate.r += .025
		else:
			$lavaBlock.modulate.r = 2
	else:
		if $lavaBlock.modulate.r > 1:
			$lavaBlock.modulate.r -= .01
		else:
			$lavaBlock.modulate.r = 1
	if $lavaBlock.modulate.r == 2:
		$"/root/World/Player".die()
