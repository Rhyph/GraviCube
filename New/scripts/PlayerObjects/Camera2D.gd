extends Camera2D


func _physics_process(delta):
	if G.Level == "Level0":
		limit_bottom = 56
		limit_left = -69
		limit_right = 496
		limit_top = -296
	
	if G.Level == "Level1":
		limit_bottom = 48
		limit_left = -69
		limit_right = 264
		limit_top = -256
	
	if G.Level == "Level2":
		limit_bottom = 72
		limit_left = -69
		limit_right = 488
		limit_top = -216
	
	if G.Level == "Level3":
		limit_bottom = 37
		limit_left = -296
		limit_right = 78
		limit_top = -513
	
	if G.Level == "Level01":
		limit_bottom = 56
		limit_left = -69
		limit_right = 328
		limit_top = -456
