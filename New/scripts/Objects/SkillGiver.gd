extends Area2D




func _ready():
	if G.GraviSwitch == true:
		queue_free()

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		$AnimationPlayer.play("pick")

func _Picked():
	G.GraviSwitch = true
	$"/root/World/Interface"._Popup()
	queue_free()
