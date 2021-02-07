extends KinematicBody2D

const GraviGun = preload("res://scenes/GraviGun.tscn")

const AIR_RESISTANCE = 0.02
const MAX_SPEED = 128
const GRAVITY = 400
const JUMP_FORCE = 92

var ACCELERATION = 512
var FRICTION = 0.2
var idleOn = true
var on_floor
var GraviMotion = Vector2()
var motion = Vector2.ZERO
var MouseMovement = false
var AnimFlor = true
var NotOnFloor = false
var is_jumping = false

#Считывает, двигается ли мышка в данный момент, чтобы флипнуть спрайт
func _input(event):
	if event is InputEventMouseMotion:
		MouseMovement = true
	else:
		MouseMovement = false

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	var direction = get_global_mouse_position().x - global_position.x
	if MouseMovement == true:
		if direction < 0:
			$player.set_flip_h(true)
		else:
			$player.set_flip_h(false)
	
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		$player.flip_h = x_input < 0
	
	motion.y += GRAVITY * delta
	
	if $IceCast.is_colliding() or $IceCast2.is_colliding() or $IceCast3.is_colliding():
		FRICTION = 0.02
		ACCELERATION = 256
	else:
		FRICTION = 0.2
		ACCELERATION = 512
	
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		$WasOnFloor.start()
		NotOnFloor = false
		AnimFlor = true
	else:
		AnimFlor = false
	
	if ($RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or \
	$RayCast2D3.is_colliding()) and (motion.y < 7 and motion.y > 6):
		on_floor = true
	else:
		on_floor = false
	
	if on_floor == true:
		is_jumping = false
		if idleOn == true:
			$AnimationPlayer.play("idle")
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("ui_up"):
			is_jumping = true
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	#Вызывает гравитационный выстрел
	if G.gravigun_off == false:
		if Input.is_action_just_pressed("ui_lmb"):
			G.gravigun_off = true
			var gravigun = GraviGun.instance()
			get_parent().add_child(gravigun)
			gravigun.position = $Position2D.global_position
	
	#Машина анимаций?)
	if motion.y < -92:
		$AnimationPlayer.play("downGravi")
	if motion.y > 7 and NotOnFloor == true and is_jumping == false:
		$AnimationPlayer.play("downNoJump")
	if motion.y == -92:
		$AnimationPlayer.play("downFast")
	if AnimFlor == true and motion.y > 7:
		idleOn = false
		$IdleOn.start()
		$AnimationPlayer.play("downFloor")
	if on_floor == false:
		if (motion.y > -12 and motion.y < 12):
			$AnimationPlayer.play("downMiddle")
	
	#Плавно возвращает время на единицу
	if Engine.time_scale < 0.975:
		Engine.time_scale += 0.025
	else:
		Engine.time_scale = 1
	#print($AnimationPlayer.current_animation)
	motion = move_and_slide(motion, Vector2.UP)

#Вектор направления отталкивая от гравитационного выстрела
func Vector():
	is_jumping = true
	GraviMotion = 200 * ((global_position - G.GraviGunPos).normalized())
	motion.y += GraviMotion.y
	motion.x += GraviMotion.x
	Engine.time_scale = 0.7 #Небольшое замедление времени во время взрыва

#Timers
func _on_IdleOn_timeout():
	idleOn = true
func _on_WasOnFloor_timeout():
	if AnimFlor == false:
		NotOnFloor = true

#Рестартает сцену, если игрок вышел за лимит камеры
func _on_VisibilityNotifier2D_screen_exited():
	get_tree().reload_current_scene()
