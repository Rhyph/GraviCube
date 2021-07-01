extends Area2D




func _ready():
	if G.PlayerPos == global_position:
		$checkpoint/AnimationPlayer.play("activated")
	else:
		$checkpoint/AnimationPlayer.play("nonactivated")

func _physics_process(delta):
	if G.PlayerPos != global_position:
		$checkpoint/AnimationPlayer.play("nonactivated")

func _on_Checkpoint_body_entered(body):
	if "Player" in body.name:
		if G.PlayerPos != global_position:
			$checkpoint/AnimationPlayer.play("pick")
		G.PlayerPos = global_position
		G.saved = true
