extends Area2D




var speed = 250
var motion = Vector2()
var ice = false

func _physics_process(delta):
	motion = ($"/root/World/Player".mousePos - $"/root/World/Player".global_position).normalized() * speed * delta
	if ice == true:
		motion.y *= -1
	translate(motion)

#Удаляет узел, если пуля вышла за камеру
func _on_VisibilityNotifier2D_screen_exited():
	$"/root/World/Player".projectile += 1
	queue_free()

func _on_GraviGun_body_entered(body):
	speed = 0
	$AnimationPlayer.play('shot')

#Игрок находится в радиусе взрыва
func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.Vector()
	if "Switcher" in body.name:
		body._Switch_On()

func _on_Timer_timeout():
	set_collision_mask(3)

func _on_Area2D2_body_entered(body):
	ice = true
