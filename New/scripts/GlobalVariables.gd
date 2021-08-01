extends Node2D


var PlayerPos = Vector2()

var Can = true
var Laved = false
var Saved = false

var Deaths = 0
var Mins = 0
var Secs = 0.0

var Level
var timer

func _ready():
	if Level != "Main Menu":
		timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_timeout") 
		add_child(timer)
		timer.start(.01)
		if Saved == false:
			PlayerPos = $"/root/World/Player".global_position
	else:
		timer.stop()

func _on_timer_timeout():
	Secs += .01
	if Mins == 9 && Secs >= 59.98:
		timer.stop()
	if Secs >= 60.0:
		Secs = 0
		Mins += 1

func scene(name):
	Deaths = 0
	Secs = 0
	Mins = 0
	get_tree().change_scene("res://scenes/levels/"+name+".tscn")
