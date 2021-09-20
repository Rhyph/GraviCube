extends Control


func _ready():
	visible = true

func _physics_process(delta):
	if "Tutorial" in G.Level:
		$Labels/Timer.visible = false
		$Labels/Deaths.visible = false
		$timer.visible = false
		$death.visible = false
	else:
		$Labels/Timer.visible = true
		$Labels/Deaths.visible = true
		$timer.visible = true
		$death.visible = true
	$Labels/Timer.text = str(G.Mins) + ":" + str(G.Secs)
	$Labels/Deaths.text = str($"/root/World/Player".deaths)
	$Labels/fps.text = str(Engine.get_frames_per_second())
	$Labels/Level.text = str(G.Level)
