extends Camera2D


func _ready():
	yield(get_tree().create_timer(.1), "timeout")
	if "Tutorial" in G.Level:
		limit_bottom = 40
		limit_left = -88
		limit_right = 88
		limit_top = -134
	if G.Level == "Level 1":
		limit_bottom = 56
		limit_left = -69
		limit_right = 360
		limit_top = -486
	if G.Level == "Level 2":
		limit_bottom = 56
		limit_left = -69
		limit_right = 232
		limit_top = -518
	if G.Level == "Level 3":
		limit_bottom = 80
		limit_left = -69
		limit_right = 496
		limit_top = -614
	if G.Level == "Level 4":
		limit_bottom = 38
		limit_left = -69
		limit_right = 264
		limit_top = -461
	if G.Level == "Level 5":
		limit_bottom = 38
		limit_left = -69
		limit_right = 352
		limit_top = -510
	if G.Level == "Level 6":
		limit_bottom = 40
		limit_left = -384
		limit_right = 140
		limit_top = -646
	if G.Level == "Level 7":
		limit_bottom = 40
		limit_left = -136
		limit_right = 280
		limit_top = -832
