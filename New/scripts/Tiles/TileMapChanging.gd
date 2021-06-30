extends TileMap




var player = 1

func _on_Timer_timeout():
	$Timer3.stop()
	$Timer2.start()
	player *= -1
	if player == -1:
		set_collision_mask(0)
		set_collision_layer(2)
		modulate = Color(2,2,2,1)
	else:
		set_collision_mask(17)
		set_collision_layer(4)
		modulate = Color(1,2,4,1)

func _on_Timer2_timeout():
	$Timer3.start()

func _on_Timer3_timeout():
	if modulate == Color(2,2,2,1) or modulate == Color(1,2,4,1):
		modulate = Color(1,1,1,1)
	elif player == -1:
		modulate = Color(2,2,2,1)
	else:
		modulate = Color(1,2,4,1)
