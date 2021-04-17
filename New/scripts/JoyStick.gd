extends TouchScreenButton

var radius = Vector2(16,16)

var inArea = false

var boundary = 32
var ongoing_drag = -1
var return_accel = 15
var ms = 300

func _process(delta):
	$Label.set_text(str(ms))
	
	$"/root/World/Interface/circlebig/Line2D".look_at($Node2D.global_position)
	
	if $"/root/World/Player".projectile == 1:
		ms = 300
	
	if ms == 300:
		$Label.visible = false
	else:
		$Label.visible = true
	
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius) - position
		position += pos_difference * return_accel * delta

func _button_pos():
	return position + radius

func _input(event):
	if inArea == true and $"/root/World/Player".projectile == 1:
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			$"/root/World/Player/RayCast2D".enabled = true
			$"/root/World/Player/RayCast2D/Line2D".visible = true
			
			var event_dist_from_center = (event.position - get_parent().global_position).length()
			
			if event_dist_from_center <= boundary or event.get_index() == ongoing_drag:
				set_global_position(event.position - radius)
				ongoing_drag = event.get_index()
				
				if _button_pos().length() > boundary:
					set_position(_button_pos().normalized() * boundary - radius)
		
		if event is InputEventScreenTouch and not event.is_pressed() and event.get_index() == ongoing_drag:
			ongoing_drag = -1
			$"/root/World/Player/RayCast2D".enabled = false
			$"/root/World/Player/RayCast2D/Line2D".visible = false
			$"/root/World/Player/".GraviShot = true

func _on_TouchScreenButton_pressed():
	if $"/root/World/Player".projectile == 1:
		$Timer.stop()
		ms = 300
		Engine.time_scale = 0.2
		inArea = true
func _on_TouchScreenButton_released():
	$Timer.start()
	Engine.time_scale = 1
	inArea = false

func _on_Timer_timeout():
	$Timer.start()
	if ms != 0:
		ms -= 10
