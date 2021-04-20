extends TileMap




func _on_Area2D2_body_entered(body):
	if "Player" in body.name:
		set_collision_mask(17)
		set_collision_layer(4)
		modulate = Color(0.58,0.24,0.98,1)
