extends TouchScreenButton


var radius = Vector2(16,16)

var inArea = false
var once = false
var down = false
var slow = false
var posed = false

var boundary = 46
var ongoing_drag = -1
var return_accel = 20
var ms = 300
var hard_func = 0

var pos_zero

func _physics_process(delta):
	if posed:
		hard_func = sqrt(pos_zero.x * pos_zero.x + pos_zero.y * pos_zero.y)
	
	if $"/root/World/Player".projectile == 1 && slow && inArea && $"/root/World/Player".is_on_floor() == false:
		Engine.time_scale = 0.1
		slow = false
	
	pos_zero = (Vector2(0,0) - radius) - position
	
	$Label.set_text(str(ms))
	
	$"/root/World/Interface/Control/circlebig/Line2D".look_at($Node2D.global_position)
	
	if $"/root/World/Player".projectile == 1:
		ms = 300
	
	if ms == 300:
		$Label.visible = false
	else:
		$Label.visible = true
	
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius) - position
		position += pos_difference * return_accel * delta
	
	if inArea && $"/root/World/Player".projectile == 1:
		if once:
			Touched()

func _button_pos():
	return position + radius

func _input(event):
	if inArea && $"/root/World/Player".projectile == 1:
		hard_func = sqrt(pos_zero.x * pos_zero.x + pos_zero.y * pos_zero.y)
		if event is InputEventScreenDrag || (event is InputEventScreenTouch && event.is_pressed()):
			down = false
			if hard_func < 14:
				$"/root/World/Player/RayCast2D".rotation_degrees = 0
			
			var event_dist_from_center = (event.position - get_parent().global_position).length()
			
			if event_dist_from_center <= boundary || event.get_index() == ongoing_drag:
				set_global_position(event.position - radius)
				ongoing_drag = event.get_index()
				
				if _button_pos().length() > boundary:
					set_position(_button_pos().normalized() * boundary - radius)
		elif ongoing_drag == -1 && posed == false:
			down = true
		if event is InputEventScreenTouch && not event.is_pressed() && event.get_index() == ongoing_drag:
			ongoing_drag = -1
			if hard_func < 14:
				down = true
			else:
				$"/root/World/Player/RayCast2D".enabled = false
				$"/root/World/Player/RayCast2D/Line2D".visible = false
				$"/root/World/Player/".GraviShot = true

func _on_TouchScreenButton_pressed():
	inArea = true
	once = true
	$"/root/World/Player/RayCast2D".visible()
	$"/root/World/Player/RayCast2D".enabled = true
	$"/root/World/Player/RayCast2D/Line2D".visible = true
func _on_TouchScreenButton_released():
	$"/root/World/Player/RayCast2D".auto()
	if down && $"/root/World/Player".projectile == 1:
		$"/root/World/Player/RayCast2D".down = true
		$"/root/World/Player/RayCast2D".under()
		$"/root/World/Player/".GraviShot = true
		$"/root/World/Player/RayCast2D".enabled = false
		$"/root/World/Player/RayCast2D/Line2D".visible = false
	once = false
	$Timer.start()
	Engine.time_scale = 1
	hard_func = 0
	inArea = false
	down = false
	posed = false

func Touched():
	once = false
	$Timer.stop()
	ms = 300
	$CheckGroundSlow.start()
	slow = true
	$"/root/World/Player".slow = true

func _on_Timer_timeout():
	$Timer.start()
	if ms != 0:
		ms -= 10
func _on_CheckGroundSlow_timeout():
	slow = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if $"/root/World/Player".projectile == 1:
		if event is InputEventScreenTouch && event.is_pressed() && inArea == false:
			posed = true
			ongoing_drag = 0
			emit_signal("pressed")
			position = event.position - Vector2(280, 140)
		
		if event is InputEventScreenTouch && event.is_pressed() == false && posed:
			emit_signal("released")
