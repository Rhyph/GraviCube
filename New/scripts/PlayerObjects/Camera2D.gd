extends Camera2D

func _physics_process(delta):
	if G.level == "Tutorial":
		limit_bottom = 56
		limit_left = -69
		limit_right = 488
		limit_top = -248
	
	if G.level == "Level0":
		limit_bottom = 72
		limit_left = -69
		limit_right = 480
		limit_top = -208
	
	if G.level == "Arena":
		limit_bottom = 8
		limit_left = -176
		limit_right = 288
		limit_top = -320
	
	if G.level == "Level1":
		limit_bottom = 8
		limit_left = -64
		limit_right = 392
		limit_top = -568
	
	if G.level == "Level2":
		limit_bottom = 10000000
		limit_left = -10000000
		limit_right = 10000000
		limit_top = -10000000
