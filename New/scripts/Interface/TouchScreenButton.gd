extends TouchScreenButton


var radius = Vector2(16,16)

var inArea = false
var once = false
var down = false
var slow = false
var shot = false

var boundary = 46
var ongoing_drag = -1
var return_accel = 20
var ms = 350
var hard_func = 0

var pos_zero

func _physics_process(delta):
	if shot && $"/root/World/Player".projectile == 1:
		if down:
			$"/root/World/Player/RayCast2D".under()
		$"/root/World/Player/RayCast2D".auto()
		$"/root/World/Player/".GraviShot = true
		$"/root/World/Player/RayCast2D".enabled = false
		shot = false
	
	if $"/root/World/Player".projectile == 1 && slow && inArea && $"/root/World/Player".SlowArea == false:
		Engine.time_scale = 0.1
		slow = false
	
	pos_zero = (Vector2(0,0) - radius) - position
	
	$Label.text = str(ms)
	
	$"/root/World/Interface/Control/circlebig/Line2D".look_at($Node2D.global_position)
	
	if $"/root/World/Player".projectile == 1:
		ms = 350
	
	if ms == 350 || ms == 0:
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
	if inArea:
		hard_func = sqrt(pos_zero.x * pos_zero.x + pos_zero.y * pos_zero.y)
		if event is InputEventScreenDrag || (event is InputEventScreenTouch && event.is_pressed()):
			down = false
			
			var event_dist_from_center = (event.position - get_parent().global_position).length()
			
			if event_dist_from_center <= boundary || event.get_index() == ongoing_drag:
				set_global_position(event.position - radius)
				ongoing_drag = event.get_index()
				
				if _button_pos().length() > boundary:
					set_position(_button_pos().normalized() * boundary - radius)
		elif ongoing_drag == -1:
			down = true
		if event is InputEventScreenTouch && not event.is_pressed() && event.get_index() == ongoing_drag:
			ongoing_drag = -1
			if hard_func < 10:
				down = true
			else:
				if $"/root/World/Player".projectile == 1:
					$"/root/World/Player/RayCast2D".auto()
					$"/root/World/Player/".GraviShot = true
					$"/root/World/Player/RayCast2D".enabled = false
				else:
					shot = true

func _on_TouchScreenButton_pressed():
	$"/root/World/Interface/Control/circlebig".modulate = Color(1, 1, 1, 1)
	$"/root/World/Interface/Control/circlebig/DarkArea".visible = true
	inArea = true
	once = true
	$"/root/World/Player/RayCast2D".visible()
	$"/root/World/Player/RayCast2D".enabled = true

func _on_TouchScreenButton_released():
	$"/root/World/Interface/Control/circlebig".modulate = Color(1, 1, 1, .5)
	$"/root/World/Interface/Control/circlebig/DarkArea".visible = false
	inArea = false
	once = false
	if down:
		if $"/root/World/Player".projectile == 1:
			$"/root/World/Player/RayCast2D".under()
			$"/root/World/Player/RayCast2D".auto()
			$"/root/World/Player/".GraviShot = true
			$"/root/World/Player/RayCast2D".enabled = false
		else:
			shot = true
	$Timer.start()
	if $"/root/World/Player".SlowArea == false:
		Engine.time_scale = 1

func Touched():
	$Timer.stop()
	$CheckGroundSlow.start()
	ms = 350
	once = false
	slow = true
	$"/root/World/Player".slow = true

func _on_Timer_timeout():
	$Timer.start()
	if ms != 0:
		ms -= 10
func _on_CheckGroundSlow_timeout():
	slow = false
