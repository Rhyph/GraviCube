extends KinematicBody2D


const GRAVIGUN = preload("res://scenes/PlayerObjects/GraviGun.tscn")
const RUNPART = preload("res://scenes/Particles/RunParticles.tscn")
const JUMPPART = preload("res://scenes/Particles/JumpParticles.tscn")

const AIR_RESISTANCE = .04
const MAX_SPEED = 64
const JUMP_FORCE = 72
const GRAVITY = 400

var acceleration = 384
var friction = .5
var projectile = 1
var keys = 2
var deaths

var slow = false
var SlowMo = false
var idleSwitch = true
var is_GraviJump = false
var dropped = false
var GraviShot = false
var limit = true

var gravigun

var LinePos = Vector2()
var motion = Vector2.ZERO

func _ready():
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_up")
	G.Can = true
	deaths = 0
	position = G.PlayerPos
	Engine.time_scale = 1

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * acceleration * delta
		$player.flip_h = x_input < 0
	
	motion.y += GRAVITY * delta
	
	if limit:
		if is_on_floor():
			motion.y = clamp(motion.y, -114, 384)
		else:
			motion.y = clamp(motion.y, -106, 384)
	
	if $Rays/IceCast.is_colliding() || $Rays/IceCast2.is_colliding():
		friction = .02
		acceleration = 256
	else:
		friction = .4
		acceleration = 384
	if $Rays/LavaCast.is_colliding() || $Rays/LavaCast2.is_colliding():
		G.Laved = true
	else:
		G.Laved = false
	if $Rays/ConvCast.is_colliding() || $Rays/ConvCast2.is_colliding():
		motion.x = clamp(motion.x, -MAX_SPEED + 32, MAX_SPEED + 32)
		if x_input == 0:
			motion.x = 32
	elif x_input != 0:
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	if is_on_floor():
		if idleSwitch:
			if x_input == 0:
				$AnimationPlayer.play("idle")
			else:
				$AnimationPlayer.play("run")
				if $Timers/Timer.is_stopped():
					$Timers/Timer.start()
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
		
	else:
		dropped = false
		$Timers/Dropped.start()
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	#Вызывает гравитационный выстрел
	if GraviShot && projectile > 0:
		LinePos = $RayCast2D/Line2D/Node2D.global_position
		GraviShot = false
		projectile -= 1
		gravigun = GRAVIGUN.instance()
		get_parent().add_child(gravigun)
		if $RayCast2D.rotation_degrees == 0:
			gravigun.rotation_degrees = 90
		else:
			gravigun.rotation_degrees = $"/root/World/Interface/Control/circlebig/Line2D".rotation_degrees
		gravigun.position = $Position2D.global_position
		$AudioStreamPlayer.play()
	
	#Плавно возвращает время на единицу
	if slow:
		$Timers/SlowMo.start()
		slow = false
	if SlowMo:
		if Engine.time_scale <= .975:
			Engine.time_scale += .025
		else:
			SlowMo = false
	
	if $"/root/World/Interface/Control/circlebig/TouchScreenButton".inArea:
		if $RayCast2D/Line2D/Node2D.global_position.x - global_position.x > 0:
			$player.set_flip_h(false)
		elif $RayCast2D/Line2D/Node2D.global_position.x - global_position.x != 0:
			$player.set_flip_h(true)
	
	animation()
	
	motion = move_and_slide(motion, Vector2.UP)

func animation():
	if motion.y < -72:
		$AnimationPlayer.play("downGravi")
	if motion.y == -72 || (is_GraviJump == false && motion.y > 7 && motion.y < 14):
		$AnimationPlayer.play("downFast")
	if dropped:
		idleSwitch = false
		$Timers/idleSwitch.start()
		$AnimationPlayer.play("downFloor")
		is_GraviJump = false
	if not is_on_floor() && motion.y > -12 && motion.y < 12 && is_GraviJump:
		$AnimationPlayer.play("downMiddle")

#Вектор направления отталкивая от гравитационного выстрела
func Vector(k):
	if k != 40:
		limit = false
	else:
		limit = true
	is_GraviJump = true
	var graviMotion = k * ((global_position - gravigun.global_position).normalized())
	motion.x = 4.5 * graviMotion.x
	motion.y = 3.5 * graviMotion.y
	if is_on_floor():
		var jumppart = JUMPPART.instance()
		get_parent().add_child(jumppart)
		jumppart.position = $Position2D2.global_position

#Для анимации приземления
func return_drop():
	dropped = false

#Рестартает сцену, если игрок вышел за лимит камеры
func _on_VisibilityNotifier2D_screen_exited():
	if G.Can:
		deaths += 1
		G.ready()
		motion = Vector2.ZERO
		position = G.PlayerPos

#Убивает игрока, если в нём есть колайдер
func _on_Area2D_body_entered(body):
	if "TileMapChanging" in body.name || "Door" in body.name && is_on_floor():
		die()
func _on_SpikeArea2D_body_entered(body):
	$AnimationPlayer.play("die")
	set_physics_process(false)
	$Timers/Die.start()

func die():
	set_physics_process(true)
	G.ready()
	$player.self_modulate = Color(1, 1, 1, 1)
	motion = Vector2.ZERO
	position = G.PlayerPos

#Timers
func _on_idleSwitch_timeout():
	idleSwitch = true
func _on_Dropped_timeout():
	if is_on_floor():
		dropped = true
func _on_SlowMo_timeout():
	if slow == false:
		SlowMo = true
		slow = true
func _on_Die_timeout():
	die()
func _on_Ghost_timeout():
	if $AnimationPlayer.current_animation == "downGravi" || $AnimationPlayer.current_animation == "downMiddle":
		var trail = preload("res://scenes/PlayerObjects/Trail.tscn").instance()
		trail.global_position = $player.global_position
		trail.flip_h = $player.flip_h
		trail.texture = $player.texture
		trail.frame = $player.frame
		trail.scale = $player.scale
		get_tree().get_root().add_child(trail)
func _on_Timer_timeout():
	if $AnimationPlayer.current_animation == "run":
		var runpart = RUNPART.instance()
		get_parent().add_child(runpart)
		runpart.position = $Position2D2.global_position
		if $player.flip_h:
			runpart.scale.y = -1
		else:
			runpart.scale.y = 1
