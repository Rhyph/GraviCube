extends StaticBody2D




var switcher = 1

func _Switch_On():
	switcher *= -1
	if switcher == -1:
		$AnimationPlayer.play("activate")
	else:
		$AnimationPlayer.play("deactivate")
	
	$"/root/World/Tiles/Locals/TileMapSwitching"._Switching()
	$"/root/World/Tiles/Locals/TileMapSwitching2"._Switching()
