extends Control


func _ready():
	visible = true

func _physics_process(delta):
	$Labels/Timer.text = str(G.Mins) + ":" + str(G.Secs)
	$Labels/Deaths.text = str($"/root/World/Player".deaths)
	$Labels/fps.text = str(Engine.get_frames_per_second())
	$Labels/Level.text = str(G.Level)
