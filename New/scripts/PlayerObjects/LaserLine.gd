extends RayCast2D


func _ready():
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	if $"/root/World/Interface/Control/circlebig/TouchScreenButton".down == false:
		if $"/root/World/Interface/Control/circlebig/TouchScreenButton".hard_func >= 14:
			rotation_degrees = $"/root/World/Interface/Control/circlebig/Line2D".rotation_degrees - 90
	
	var cast_point = cast_to
	
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		var x = cast_point.x
		var y = cast_point.y - 8
		y = clamp(y, 0, 92)
		cast_point = Vector2(x, y)
	
	$Line2D.points[1] = cast_point

func under():
	rotation_degrees = 0

func auto():
	$shoot/AnimationPlayer.play("auto")
func visible():
	$shoot/AnimationPlayer.play("visible")
