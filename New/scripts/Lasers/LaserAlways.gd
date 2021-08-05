extends RayCast2D


func _ready():
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	var cast_point = cast_to
	
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles.global_rotation = get_collision_normal().angle()
		$CollisionParticles.position = cast_point
	
	$Line2D.points[1] = cast_point
	$BeamParticles.position = cast_point * 0.5
	$BeamParticles.process_material.emission_box_extents.x = cast_point.length() * 2.3
	$RayCastIce.cast_to.x = cast_point.length()
	$RayCastPlayer.cast_to.x = cast_point.length()
	if $RayCastPlayer.is_colliding():
		$"/root/World/Player".die()
	if $RayCastIce.is_colliding():
		$"/root/World/Tiles/Ice/TileMapIce"._Laser()
