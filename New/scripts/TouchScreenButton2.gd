extends TouchScreenButton

var radius = Vector2(12,12)

var inArea = false
var down = false

var boundary = 32
var ongoing_drag = -1
var return_accel = 20

var pos_zero

func _ready():
	modulate = Color(0, 0, 0, 0)

func _process(delta):
	pos_zero = (Vector2(0,0) - radius) - position
	position.x = clamp(position.x, -48, 32)
	position.y = clamp(position.y, -48, -16)
	
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius) - position
		position += pos_difference * return_accel * delta

func _button_pos():
	return position + radius

func _input(event):
	if inArea == true:
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			var event_dist_from_center = (event.position - get_parent().global_position).length()
			
			if sqrt(pos_zero.x * pos_zero.x + pos_zero.y * pos_zero.y) > 30:
				if position.x <= -45 and position.y >= -29.5:
					Input.action_release("ui_up")
					Input.action_release("ui_right")
					Input.action_press("ui_left")
				elif position.x < -28 and position.y > -45.5:
					if position.y < -29.5:
						Input.action_release("ui_right")
						Input.action_press("ui_left")
						Input.action_press("ui_up")
						Input.action_release("ui_right")
				elif position.x <= -4 and position.y <= -45.5:
					Input.action_release("ui_left")
					Input.action_release("ui_right")
					Input.action_press("ui_up")
				elif position.x < 13 and position.y <= -29.5:
					Input.action_release("ui_left")
					Input.action_press("ui_right")
					Input.action_press("ui_up")
				else:
					Input.action_release("ui_up")
					Input.action_release("ui_left")
					Input.action_press("ui_right")
			else:
				if position.x < -30 and position.y > -20:
					Input.action_press("ui_left")
				else:
					Input.action_release("ui_left")
				if position.x > -2 and position.y > -20:
					Input.action_press("ui_right")
				else:
					Input.action_release("ui_right")
				if position.x > -22 and position.x < -10 and position.y < -32:
					Input.action_press("ui_up")
				else:
					Input.action_release("ui_up")
			
			if event_dist_from_center <= boundary or event.get_index() == ongoing_drag:
				set_global_position(event.position - radius)
				ongoing_drag = event.get_index()
				
				if _button_pos().length() > boundary:
					set_position(_button_pos().normalized() * boundary - radius)
		if event is InputEventScreenTouch and not event.is_pressed() and event.get_index() == ongoing_drag:
			ongoing_drag = -1

func _on_TouchScreenButton_pressed():
	modulate = Color(1, 1, 1, 1)
	inArea = true
func _on_TouchScreenButton_released():
	modulate = Color(0, 0, 0, 0)
	inArea = false
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")
