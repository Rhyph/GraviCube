extends Control


func _ready():
	visible = true

func _physics_process(delta):
	$Labels/Timer.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	$Labels/Death_count.text = "Death count: " + str(G.Deaths)
	$Labels/Keys_count.text = str(-$"/root/World/Player".keys + 2) + "/2"
