extends KinematicBody2D

const GRAVIGUN = preload("res://scenes/GraviGun.tscn")

const AIR_RESISTANCE = .02
const MAX_SPEED = 64
const JUMP_FORCE = 72
const GRAVITY = 400

var acceleration = 384
var friction = .4
var projectile = 1

var Slow = false
var SlowMo = false
var idleSwitch = true
var is_jumping = false
var is_GraviJump = false
var dropped = false
var GraviShot = false
var Kayotte = true

var gravigun

var GraviBoost
var LinePos = Vector2()
var motion = Vector2.ZERO

func _ready():
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")
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
	
	GraviBoost = motion.y
	GraviBoost = clamp(GraviBoost, -128, 128)
	
	if $IceCast.is_colliding() or $IceCast2.is_colliding():
		friction = .02
		acceleration = 256
	else:
		friction = .4
		acceleration = 384
	
	if is_on_floor():
		$Timers/Kayotte.start()
		Kayotte = true
		is_jumping = false
		if idleSwitch:
			if x_input == 0:
				$AnimationPlayer.play("idle")
			else:
				$AnimationPlayer.play("run")
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
		
		if Input.is_action_pressed("ui_up"):
			is_jumping = true
			motion.y = -JUMP_FORCE
	else:
		dropped = false
		$Timers/Dropped.start()
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
		
		if Kayotte == true:
			if Input.is_action_pressed("ui_up"):
				is_jumping = true
				motion.y = -JUMP_FORCE
	
	#Вызывает гравитационный выстрел
	if G.GraviSwitch:
		if GraviShot and projectile > 0:
			LinePos = $RayCast2D/Line2D/Node2D.global_position
			GraviShot = false
			projectile -= 1
			gravigun = GRAVIGUN.instance()
			get_parent().add_child(gravigun)
			gravigun.position = $Position2D.global_position
	
	#Плавно возвращает время на единицу
	if Slow:
		$Timers/SlowMo.start()
		Slow = false
	if SlowMo:
		if Engine.time_scale <= .975:
			Engine.time_scale += .025
		else:
			SlowMo = false
	
	if $"/root/World/Interface/circlebig/TouchScreenButton".inArea:
		if $RayCast2D/Line2D/Node2D.global_position.x - global_position.x > 0:
			$player.set_flip_h(false)
		elif $RayCast2D/Line2D/Node2D.global_position.x - global_position.x != 0:
			$player.set_flip_h(true)
	
	animation()
	
	motion = move_and_slide(motion, Vector2.UP)

func animation():
	if motion.y < -72:
		$AnimationPlayer.play("downGravi")
	if motion.y == -72 or (is_jumping == false and is_GraviJump == false and motion.y > 7 and motion.y < 14):
		$AnimationPlayer.play("downFast")
	if dropped:
		idleSwitch = false
		$Timers/idleSwitch.start()
		$AnimationPlayer.play("downFloor")
		is_GraviJump = false
	if not is_on_floor() and motion.y > -12 and motion.y < 12 and is_GraviJump:
		$AnimationPlayer.play("downMiddle")

#Вектор направления отталкивая от гравитационного выстрела
func Vector():
	is_GraviJump = true
	var graviMotion = 40 * ((global_position - gravigun.global_position).normalized())
	motion.x = 4 * graviMotion.x
	if graviMotion.y >= 0:
		motion.y = 3 * graviMotion.y + abs(GraviBoost / 2)
	else:
		motion.y = 3 * graviMotion.y - abs(GraviBoost / 2)

func _return_drop():
	dropped = false

#Рестартает сцену, если игрок вышел за лимит камеры
func _on_VisibilityNotifier2D_screen_exited():
	if G.can:
		get_tree().reload_current_scene()
#Убивает игрока, если в нём есть колайдер
func _on_Area2D_body_entered(body):
	if not "1wayblock" in body.name:
		die()

func die():
	$"/root/World/Interface/circlebig".visible = false
	get_tree().reload_current_scene()

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

func _on_Kayotte_timeout():
	if not is_on_floor():
		Kayotte = false
