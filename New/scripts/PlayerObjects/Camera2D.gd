extends Camera2D

func _physics_process(delta):
	if G.level == "World":
		limit_bottom = 10000000
		limit_left = -10000000
		limit_right = 10000000
		limit_top = -10000000
		#limit_bottom = 8
		#limit_left = -104
		#limit_right = 104
		#limit_top = -64
	
	if G.level == "Tutorial":
		limit_bottom = 88
		limit_left = -16
		limit_right = 936
		limit_top = -80
	
	if G.level == "Arena":
		limit_bottom = 8
		limit_left = -176
		limit_right = 288
		limit_top = -320
	
	if G.level == "Level1":
		limit_bottom = 8
		limit_left = -65
		limit_right = 391
		limit_top = -568
	
	if G.level == "Level2":
		limit_bottom = 10000000
		limit_left = -10000000
		limit_right = 10000000
		limit_top = -10000000
