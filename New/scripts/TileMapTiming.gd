extends TileMap

var ms = 1100


func _process(delta):
	if ms != 0:
		$"/root/World/Texts/Label".set_text(str(ms))
	else:
		$TimerMs.stop()
	

func _on_Area2D2_body_entered(body):
	if "Player" in body.name:
		$TimerMinute.start()
		$TimerMs.start()

func _on_TimerMinute_timeout():
	set_collision_mask(0)
	set_collision_layer(2)
	modulate = Color(1,1,1,0.59)

func _on_TimerMs_timeout():
	ms -= 1
	$TimerMs.start()
