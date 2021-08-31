extends Control


func _ready():
	visible = true

func _physics_process(delta):
	$Labels/Timer.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	$Labels/Death_count.text = "Deaths: " + str(G.Deaths)
	$Labels/fps.text = "Fps: " + str(Engine.get_frames_per_second())
