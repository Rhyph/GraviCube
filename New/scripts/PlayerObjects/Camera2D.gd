extends Camera2D

func _process(delta):
	if G.level == "World":
		limit_bottom = 8
		limit_left = -104
		limit_right = 104
		limit_top = -64
	
	if G.level == "Tutorial":
		limit_bottom = 96
		limit_left = -8
		limit_right = 936
		limit_top = -40
	
	if G.level == "Arena":
		limit_bottom = 8
		limit_left = -176
		limit_right = 288
		limit_top = -320
	
	if G.level == "Level1":
		limit_bottom = 8
		limit_left = -48
		limit_right = 364
		limit_top = -536
