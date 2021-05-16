extends StaticBody2D




var switcher = 1

func _Switch_On():
	switcher *= -1
	if switcher == -1:
		$AnimationPlayer.play("activate")
	else:
		$AnimationPlayer.play("deactivate")
	if $"/root/World/Lasers/SwitchLaserStatic".Switch == false:
		$"/root/World/Lasers/SwitchLaserStatic".Switch = true
	else:
		$"/root/World/Lasers/SwitchLaserStatic".Switch = false
	
	$"/root/World/Tiles/Locals/Local3TileMapSwitching"._Switching()
