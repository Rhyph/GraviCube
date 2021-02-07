extends Area2D




var speed = 250
var motion = Vector2()

func _physics_process(delta):
	motion = (get_global_mouse_position() - $"/root/World/Player".global_position).normalized() * speed * delta
	translate(motion)

#Убирает узел, если пуля вышла за камеру
func _on_VisibilityNotifier2D_screen_exited():
	G.gravigun_off = false
	queue_free()

func _on_GraviGun_body_entered(body):
	speed = 0
	$AnimationPlayer.play('shot')

#Игрок находится в радиусе взрыва
func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		G.GraviGunPos = global_position
		body.Vector()

func _on_Timer_timeout():
	set_collision_mask(3)
