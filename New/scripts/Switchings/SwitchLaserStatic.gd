extends RayCast2D

var Switch = false setget set_is_casting

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta):
	var cast_point = cast_to
	
	force_raycast_update()
	
	$CollisionParticles.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles.global_rotation = get_collision_normal().angle()
		$CollisionParticles.position = cast_point
	
	$Line2D.points[1] = cast_point
	$BeamParticles.position = cast_point * 0.5
	$BeamParticles.process_material.emission_box_extents.x = cast_point.length() * 2.3
	$RayCastPlayer.cast_to.x = cast_point.length()
	if $RayCastPlayer.is_colliding():
		get_tree().reload_current_scene()
	$RayCastIce.cast_to.x = cast_point.length()
	if $RayCastIce.is_colliding():
		$"/root/World/Tiles/Ice/TileMapIce"._Laser()

func set_is_casting(cast):
	Switch = cast
	
	$BeamParticles.emitting = Switch
	$CastingParticles.emitting = Switch
	if Switch:
		appear()
	else:
		$CollisionParticles.emitting = false
		disappear()
	set_physics_process(Switch)

func appear():
	$appear.start()
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 1.0, 0.2)
	$Tween.start()

func disappear():
	$RayCastPlayer.enabled = false
	$RayCastIce.enabled = false
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 1.0, 0, 0.1)
	$Tween.start()

func _on_appear_timeout():
	$RayCastPlayer.enabled = true
	$RayCastIce.enabled = true
