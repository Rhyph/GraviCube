extends Camera2D

func _process(delta):
	if G.level == "World":
		limit_bottom = 8
		limit_left = -104
		limit_right = 104
		limit_top = -64
	
	if G.level == "Tutorial":
		limit_bottom = 88
		limit_left = -24
		limit_right = 776
		limit_top = -24
	
	if G.level == "Arena":
		limit_bottom = 8
		limit_left = -176
		limit_right = 288
		limit_top = -320
	
	#if G.level == "Level1":
	#	limit_bottom = 
	#	limit_left = 
	#	limit_right = 
	#	limit_top = 
