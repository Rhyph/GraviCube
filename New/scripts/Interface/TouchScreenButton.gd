extends TouchScreenButton

var radius = Vector2(16,16)

var inArea = false
var once = false
var down = false

var boundary = 46
var ongoing_drag = -1
var return_accel = 20
var ms = 400

var pos_zero

func _physics_process(delta):
	pos_zero = (Vector2(0,0) - radius) - position
	
	$Label.set_text(str(ms))
	
	$"/root/World/Interface/circlebig/Line2D".look_at($Node2D.global_position)
	
	if $"/root/World/Player".projectile == 1:
		ms = 400
	
	if ms == 400:
		$Label.visible = false
	else:
		$Label.visible = true
	
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius) - position
		position += pos_difference * return_accel * delta
	
	if inArea == true and $"/root/World/Player".projectile == 1:
		if once == true:
			Touched()

func _button_pos():
	return position + radius

func _input(event):
	if inArea == true and $"/root/World/Player".projectile == 1:
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			down = false
			$"/root/World/Player/RayCast2D".enabled = true
			$"/root/World/Player/RayCast2D/Line2D".visible = true
			
			var event_dist_from_center = (event.position - get_parent().global_position).length()
			
			if event_dist_from_center <= boundary or event.get_index() == ongoing_drag:
				set_global_position(event.position - radius)
				ongoing_drag = event.get_index()
				
				if _button_pos().length() > boundary:
					set_position(_button_pos().normalized() * boundary - radius)
		elif ongoing_drag == -1:
			down = true
		if event is InputEventScreenTouch and not event.is_pressed() and event.get_index() == ongoing_drag:
			ongoing_drag = -1
			if sqrt(pos_zero.x * pos_zero.x + pos_zero.y * pos_zero.y) < 14:
				down = true
			else:
				$"/root/World/Player/RayCast2D".enabled = false
				$"/root/World/Player/RayCast2D/Line2D".visible = false
				$"/root/World/Player/".GraviShot = true

func _on_TouchScreenButton_pressed():
	inArea = true
	once = true
func _on_TouchScreenButton_released():
	if down == true and $"/root/World/Player".projectile == 1:
		$"/root/World/Player/RayCast2D".under()
		$"/root/World/Player/".GraviShot = true
		$"/root/World/Player/RayCast2D".down = true
		$"/root/World/Player/RayCast2D".enabled = false
		$"/root/World/Player/RayCast2D/Line2D".visible = false
	once = false
	$Timer.start()
	Engine.time_scale = 1
	inArea = false

func _on_Timer_timeout():
	$Timer.start()
	if ms != 0:
		ms -= 10

func Touched():
	once = false
	$Timer.stop()
	ms = 400
	Engine.time_scale = 0.1
	$"/root/World/Player".Slow = true
