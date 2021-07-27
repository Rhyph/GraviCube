extends Area2D


var picked = false

func _ready():
	$Particles2D.process_material.gravity = Vector3(0, 0, 0)

func _physics_process(delta):
	if picked:
		$Particles2D.process_material.gravity.x = ($"/root/World/Player".global_position.x - global_position.x) * 20
		$Particles2D.process_material.gravity.y = ($"/root/World/Player".global_position.y - global_position.y) * 20

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		if picked == false:
			$AnimationPlayer.play("picked")
			$"/root/World/Player".keys -= 1
		picked = true

func deleting():
	$Particles2D.process_material.gravity = Vector3(0, 0, 0)
	queue_free()
