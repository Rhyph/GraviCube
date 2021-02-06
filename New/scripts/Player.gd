extends KinematicBody2D

const GraviGun = preload("res://scenes/GraviGun.tscn")

const AIR_RESISTANCE = 0.02
const ACCELERATION = 512
const MAX_SPEED = 128
const GRAVITY = 400
const JUMP_FORCE = 92

var FRICTION = 0.2
var idleOn = true
var on_floor
var GraviMotion = Vector2()
var motion = Vector2.ZERO

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	motion.y += GRAVITY * delta
	
	if $IceRays/IceCast.is_colliding() or $IceRays/IceCast2.is_colliding() or $IceRays/IceCast3.is_colliding():
		FRICTION = 0.02
	else:
		FRICTION = 0.2
	
	if ($FlorRays/RayCast2D.is_colliding() or $FlorRays/RayCast2D2.is_colliding() or $FlorRays/RayCast2D3.is_colliding()) \
	and (motion.y < 7 and motion.y > 6):
		on_floor = true
	else:
		on_floor = false
	
	if on_floor == true:
		if idleOn == true:
			$AnimationPlayer.play("idle")
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	if G.gravigun_off == false:
		if Input.is_action_just_pressed("ui_lmb"):
			G.gravigun_off = true
			var gravigun = GraviGun.instance()
			get_parent().add_child(gravigun)
			gravigun.position = $Position2D.global_position
	
	if motion.y == -92 or (motion.y > 7 and on_floor == true):
		$AnimationPlayer.play("down")
	if on_floor == true and motion.y > 7:
		idleOn = false
		$IdleOn.start()
		$AnimationPlayer.play("downUp")
	if (motion.y < -12 and motion.y < 8):
		$AnimationPlayer.play("down2")
	
	if Engine.time_scale < 0.975:
		Engine.time_scale += 0.025
	else:
		Engine.time_scale = 1
	
	flip()
	
	motion = move_and_slide(motion, Vector2.UP)

func Vector():
	GraviMotion = 200 * ((global_position - G.GraviGunPos).normalized())
	motion.y += GraviMotion.y
	motion.x += GraviMotion.x
	Engine.time_scale = 0.7

func _on_IdleOn_timeout():
	idleOn = true

func flip():
	var direction = get_global_mouse_position().x - global_position.x
	if direction < 0:
		$player.set_flip_h(true)
	else:
		$player.set_flip_h(false)
