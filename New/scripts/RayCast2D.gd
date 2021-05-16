extends RayCast2D




func _ready():
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	if $"/root/World/Interface/circlebig/TouchScreenButton".inArea == true:
		rotation_degrees = $"/root/World/Interface/circlebig/Line2D".rotation_degrees - 90
	
	var cast_point = cast_to
	
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	
	$Line2D.points[1] = cast_point
