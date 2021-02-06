extends AnimatedSprite




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	position = get_global_mouse_position()

func _on_Area2D_body_entered(body):
	play("Red")

func _on_Area2D_body_exited(body):
	play("Default")
