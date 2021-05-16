extends KinematicBody2D

const GRAVIGUN = preload("res://scenes/GraviGun.tscn")

const AIR_RESISTANCE = 0.02
const MAX_SPEED = 64
const JUMP_FORCE = 92
const GRAVITY = 400

var acceleration = 512
var friction = 0.2
var projectile = 1

var Slow = false
var SlowMo = false
var idleSwitch = true
var is_jumping = false
var is_GraviJump = false
var dropped = false
var GraviShot = false

var gravigun

var LinePos = Vector2()
var motion = Vector2.ZERO

func _ready():
	G.can = true
	position = G.PlayerPos
	Engine.time_scale = 1

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
		if idleSwitch == true:
			$AnimationPlayer.play("idle")
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
		
		if Input.is_action_pressed("ui_up"):
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
	if G.GraviSwitch == true:
		if GraviShot == true and projectile > 0:
			LinePos = $RayCast2D/Line2D/Node2D.global_position
			GraviShot = false
			projectile -= 1
			gravigun = GRAVIGUN.instance()
			get_parent().add_child(gravigun)
			gravigun.position = $Position2D.global_position
	
	#Плавно возвращает время на единицу
	if Slow == true:
		$Timers/SlowMo.start()
		Slow = false
	if SlowMo == true:
		if Engine.time_scale <= 0.975:
			Engine.time_scale += 0.025
		else:
			SlowMo = false
	
	if $"/root/World/Interface/circlebig/TouchScreenButton".inArea == true:
		if $RayCast2D/Line2D/Node2D.global_position.x - global_position.x >= 0:
			$player.set_flip_h(false)
		else:
			$player.set_flip_h(true)
	
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
		idleSwitch = false
		$Timers/idleSwitch.start()
		$AnimationPlayer.play("downFloor")
	if not is_on_floor() and motion.y > -12 and motion.y < 12 and is_GraviJump == true:
		$AnimationPlayer.play("downMiddle")

#Вектор направления отталкивая от гравитационного выстрела
func Vector():
	is_GraviJump = true
	var graviMotion = 50 * ((global_position - gravigun.global_position).normalized())
	motion.y = 3 * graviMotion.y
	motion.x = 4 * graviMotion.x

func die():
	$"/root/World/Interface/circlebig".visible = false
	$"/root/World/Interface/Buttons".visible = false
	get_tree().reload_current_scene()

func _return_drop():
	dropped = false

#Рестартает сцену, если игрок вышел за лимит камеры
func _on_VisibilityNotifier2D_screen_exited():
	if G.can == true:
		get_tree().reload_current_scene()
func _on_Area2D_body_entered(body):
	die()

#Timers
func _on_idleSwitch_timeout():
	idleSwitch = true
func _on_Dropped_timeout():
	if is_on_floor():
		dropped = true
func _on_SlowMo_timeout():
	if Slow == false:
		SlowMo = true
		Slow = true
