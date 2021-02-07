extends KinematicBody2D

const GRAVIGUN = preload("res://scenes/GraviGun.tscn")

const AIR_RESISTANCE = 0.02
const MAX_SPEED = 128
const GRAVITY = 400
const JUMP_FORCE = 92

var acceleration = 512
var friction = 0.2
var projectile = 1

var idleOn = true
var is_jumping = false
var is_GraviJump = false
var dropped = false

var gravigun

var graviMotion = Vector2()
var motion = Vector2.ZERO

#Считывает, двигается ли мышка в данный момент, чтобы флипнуть спрайт
func _input(event):
	if event is InputEventMouseMotion and motion.x < 3 and motion.y < 7:
		var direction_of_view = (global_position - get_global_mouse_position()).normalized()
		turn(direction_of_view.x)

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if x_input != 0:
		motion.x += x_input * acceleration * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		$player.flip_h = x_input < 0
	
	motion.y += GRAVITY * delta
	
	if $IceCast.is_colliding() or $IceCast2.is_colliding():
		friction = 0.02
		acceleration = 256
	else:
		friction = 0.2
		acceleration = 512
	
	if is_on_floor():
		is_jumping = false
		if idleOn == true:
			$AnimationPlayer.play("idle")
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
		
		if Input.is_action_just_pressed("ui_up"):
			is_jumping = true
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	if not is_on_floor():
		dropped = false
		$Timers/Dropped.start()
	
	#Вызывает гравитационный выстрел
	if Input.is_action_just_pressed("ui_lmb") and projectile > 0:
		projectile -= 1
		gravigun = GRAVIGUN.instance()
		get_parent().add_child(gravigun)
		gravigun.position = $Position2D.global_position
	
	#Плавно возвращает время на единицу
	if Engine.time_scale < 0.975:
		Engine.time_scale += 0.025
	else:
		Engine.time_scale = 1
	
	animation()
	
	motion = move_and_slide(motion, Vector2.UP)

func animation():
	if motion.y < -92:
		$AnimationPlayer.play("downGravi")
	if motion.y == -92:
		$AnimationPlayer.play("downFast")
	if (is_jumping == false and is_GraviJump == false) and (motion.y > 7 and motion.y < 14):
		$AnimationPlayer.play("downNoJump")
	if dropped == true:
		idleOn = false
		$Timers/IdleOn.start()
		$AnimationPlayer.play("downFloor")
	if not is_on_floor() and motion.y > -12 and motion.y < 12 and is_GraviJump == true:
		$AnimationPlayer.play("downMiddle")

func turn(direction_of_view):
	if direction_of_view > 0:
		$player.set_flip_h(true)
	else:
		$player.set_flip_h(false)

#Вектор направления отталкивая от гравитационного выстрела
func Vector():
	is_GraviJump = true
	graviMotion = 50 * ((global_position - gravigun.global_position).normalized())
	if graviMotion.y > 0:
		if motion.y < 0:
			motion.y = 3*graviMotion.y
		else:
			motion.y = 3*graviMotion.y
	else:
		if motion.y > 0:
			motion.y = 3*graviMotion.y
		else:
			motion.y = 3*graviMotion.y
	if graviMotion.x > 0:
		if motion.x < 0:
			motion.x = 4*graviMotion.x
		else:
			motion.x = 4*graviMotion.x
	else:
		if motion.x > 0:
			motion.x = 4*graviMotion.x
		else:
			motion.x = 4*graviMotion.x
	Engine.time_scale = 0.7 #Небольшое замедление времени во время взрыва

#Timers
func _on_IdleOn_timeout():
	idleOn = true
func _on_Dropped_timeout():
	if is_on_floor():
		dropped = true

func _return_drop():
	dropped = false

#Рестартает сцену, если игрок вышел за лимит камеры
func _on_VisibilityNotifier2D_screen_exited():
	get_tree().reload_current_scene()
