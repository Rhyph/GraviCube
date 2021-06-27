extends TouchScreenButton

var radius = Vector2(10,10)

var inArea = false
var down = false

var boundary = 28
var ongoing_drag = -1
var return_accel = 20

var pos_zero

func _ready():
	modulate = Color(0, 0, 0, 0)

func _process(delta):
	pos_zero = (Vector2(0,0) - radius) - position
	position.x = clamp(position.x, -48, 28)
	position.y = clamp(position.y, -48, -10)
	
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0,0) - radius) - position
		position += pos_difference * return_accel * delta

func _button_pos():
	return position + radius

func _input(event):
	if inArea == true:
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			var event_dist_from_center = (event.position - get_parent().global_position).length()
			
			if sqrt(pos_zero.x * pos_zero.x + pos_zero.y * pos_zero.y) > 25:
				if pos_zero.x >= 25 and pos_zero.y < 11:
					Input.action_release("ui_up")
					Input.action_release("ui_right")
					Input.action_press("ui_left")
				elif pos_zero.x < 25 and pos_zero.y >= 11 and pos_zero.x > 10.5 and pos_zero.y < 25.5:
					Input.action_release("ui_right")
					Input.action_press("ui_left")
					Input.action_press("ui_up")
					Input.action_release("ui_right")
				elif pos_zero.x >= -10.5 and pos_zero.x <= 10.5 and pos_zero.y >= 25.5:
					Input.action_release("ui_left")
					Input.action_release("ui_right")
					Input.action_press("ui_up")
				elif pos_zero.x > -25 and pos_zero.x < -10.5 and pos_zero.y < 25.5 and pos_zero.y >= 11:
					Input.action_release("ui_left")
					Input.action_press("ui_right")
					Input.action_press("ui_up")
				elif pos_zero.x <= -25 and pos_zero.y < 11:
					Input.action_release("ui_up")
					Input.action_release("ui_left")
					Input.action_press("ui_right")
			else:
				if pos_zero.x > 14 and pos_zero.y < 8:
					Input.action_press("ui_left")
				else:
					Input.action_release("ui_left")
				if pos_zero.x < -14 and pos_zero.y < 8:
					Input.action_press("ui_right")
				else:
					Input.action_release("ui_right")
				if pos_zero.y > 14 and pos_zero.x > -7 and pos_zero.x < 7:
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
