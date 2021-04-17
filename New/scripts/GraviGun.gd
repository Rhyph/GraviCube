extends Area2D




var speed = 200
var motion = Vector2()
var ice = false
var sig = true
var fast = true

func _physics_process(delta):
	if sig == true:
		motion = ($"/root/World/Player".LinePos - $"/root/World/Player".global_position).normalized() * speed * delta
		sig = false
	if ice == true:
		motion.y *= -1
	translate(motion)

#Удаляет узел, если пуля вышла за камеру
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	if fast == true:
		$"/root/World/Player".projectile = 1
		fast = false

func _on_GraviGun_body_entered(body):
	sig = true
	speed = 0
	$AnimationPlayer.play('shot')

#Тело находится в радиусе взрыва
func _on_Area2D_body_entered(body):
	if "Switcher" in body.name:
		body._Switch_On()
	if "Player" in body.name:
		body.Vector()

func _on_Timer_timeout():
	set_collision_mask(3)

func _on_Area2D2_body_entered(body):
	ice = true

func _on_Timer2_timeout():
	if fast == true:
		$"/root/World/Player".projectile = 1
		fast = false
