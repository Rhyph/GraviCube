extends Camera2D

func _physics_process(delta):
	if G.level == "Tutorial":
		limit_bottom = 38
		limit_left = -70
		limit_right = 1024
		limit_top = -204
	
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
