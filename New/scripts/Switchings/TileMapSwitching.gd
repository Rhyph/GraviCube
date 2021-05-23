extends TileMap




var player = 1

func _Switching():
	player *= -1
	if player == -1:
		set_collision_mask(0)
		set_collision_layer(2)
		modulate = Color(2,2,2,1)
	else:
		set_collision_mask(17)
		set_collision_layer(4)
		modulate = Color(1,2,4,1)
