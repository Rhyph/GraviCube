extends Control


func _ready():
	visible = true

func _physics_process(delta):
	$Labels/Timer.text = str(G.Mins) + ":" + str(G.Secs)
	#$Labels/fps.text = str(Engine.get_frames_per_second())
