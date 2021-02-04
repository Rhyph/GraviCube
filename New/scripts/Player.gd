extends KinematicBody2D

const GraviGun = preload("res://scenes/GraviGun.tscn")

const AIR_RESISTANCE = 0.02
const ACCELERATION = 512
const FRICTION = 0.1
const MAX_SPEED = 128
const GRAVITY = 400
const JUMP_FORCE = 144

var direction = "right"
var on_floor
var GraviMotion = Vector2()
var motion = Vector2.ZERO

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		$player.flip_h = x_input < 0
		if x_input < 0:
			direction = "left"
		else:
			direction = "right"
	
	motion.y += GRAVITY * delta
	
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding() or $RayCast2D3.is_colliding():
		on_floor = true
	else:
		on_floor = false
	
	if on_floor == true:
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
	
	motion = move_and_slide(motion, Vector2.UP)

func Vector():
	GraviMotion = 200 * ((global_position - G.GraviGunPos).normalized())
	motion.y += GraviMotion.y
	motion.x += GraviMotion.x
