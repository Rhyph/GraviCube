extends StaticBody2D


func _physics_process(delta):
	if G.Laved:
		if $lavaBlock.modulate.r < 2:
			$lavaBlock.modulate.r += .025
			$Light2D.energy += .025
		else:
			$lavaBlock.modulate.r = 2
			$Light2D.energy = 1
	else:
		if $lavaBlock.modulate.r > 1:
			$lavaBlock.modulate.r -= .01
			$Light2D.energy -= .01
		else:
			$lavaBlock.modulate.r = 1
			$Light2D.energy = 0
	if $lavaBlock.modulate.r == 2:
		$"/root/World/Player".die()
