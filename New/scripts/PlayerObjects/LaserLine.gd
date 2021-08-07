extends RayCast2D


var switch = false
var down = false

func _ready():
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	if $"/root/World/Interface/Control/circlebig/TouchScreenButton".down == false:
		if $"/root/World/Interface/Control/circlebig/TouchScreenButton".inArea:
			$shoot/AnimationPlayer.play("visible")
			switch = true
			rotation_degrees = $"/root/World/Interface/Control/circlebig/Line2D".rotation_degrees - 90
		else:
			if switch == true:
				$shoot/AnimationPlayer.play("auto")
			switch = false
	
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
	if down:
		$shoot/AnimationPlayer.play("auto")
		down = false
