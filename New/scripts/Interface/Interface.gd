extends CanvasLayer




func _ready():
	$Control.visible = true

func _physics_process(delta):
	$Control/Labels/Timer.text = "Time: " + str(G.Mins) + ":" + str(G.Secs)
	$Control/Labels/Death_count.text = "Death count: " + str(G.Deaths)
	$Control/Labels/Keys_count.text = str(-$"/root/World/Player".keys + 2) + "/2"
