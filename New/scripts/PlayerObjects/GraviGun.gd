extends Area2D


const PARTICLES = preload("res://scenes/PlayerObjects/BulletParticles.tscn")

var speed = 400
var k = 40
var i = 0
var j = 0

var motion = Vector2()

var sig = true
var fast = true
var part = true

var particles
var point

func _physics_process(delta):
	if point:
		$bullet.look_at(point)
	
	if i == 2:
		i = 0
		motion.y *= -1
	
	if part:
		particles = PARTICLES.instance()
		get_parent().add_child(particles)
		particles.position = $Position2D.global_position
	if sig:
		motion = ($"/root/World/Player".LinePos - $"/root/World/Player".global_position).normalized() * speed * delta
		sig = false
	translate(motion)
	
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding():
		sig = true
		part = false
		speed = 0
		$AnimationPlayer.play('shot')

#Удаляет узел, если пуля вышла за камеру
func _on_VisibilityNotifier2D_screen_exited():
	part = false
	if fast:
		$"/root/World/Player".projectile = 1
		fast = false
	queue_free()

func _on_GraviGun_body_entered(body):
	sig = true
	part = false
	speed = 0
	$AnimationPlayer.play('shot')

func _on_Area2D3_body_entered(body):
	k = 40
	if "Red" in body.name:
		k *= 1.5
	if "Inverted" in body.name:
		k *= -1.5

#Тело находится в радиусе взрыва
func _on_Area2D_body_entered(body):
	$AudioStreamPlayer.play()
	if "Switcher" in body.name:
		body._Switch_On()
	if "Player" in body.name:
		body.Vector(k)

func _on_Timer_timeout():
	set_collision_mask(3)

func _on_Area2D2_body_entered(body):
	motion.y *= -1
	point = $Trail.points[0]
	i += 1

func _on_Area2D2_body_exited(body):
	i = 0

func _on_Timer2_timeout():
	if fast:
		$"/root/World/Player".projectile = 1
		fast = false
