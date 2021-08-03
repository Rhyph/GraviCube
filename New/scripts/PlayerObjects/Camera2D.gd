extends Camera2D

func _physics_process(delta):
	if G.Level == "Level0":
		limit_bottom = 56
		limit_left = -69
		limit_right = 496
		limit_top = -256
	
	if G.Level == "Level1":
		limit_bottom = 72
		limit_left = -69
		limit_right = 488
		limit_top = -216
	
	if G.Level == "Arena":
		limit_bottom = 8
		limit_left = -176
		limit_right = 288
		limit_top = -320
	
	if G.Level == "Level2":
		limit_bottom = 8
		limit_left = -64
		limit_right = 392
		limit_top = -568
	
	if G.Level == "Level3":
		limit_bottom = 10000000
		limit_left = -10000000
		limit_right = 10000000
		limit_top = -10000000
	
	if G.Level == "Level4":
		limit_bottom = 10000000
		limit_left = -10000000
		limit_right = 10000000
		limit_top = -10000000
