extends Node2D


var PlayerPos = Vector2()

var Can = true
var Laved = false
var Saved = false
var TP = false

var Deaths = 0
var Mins = 0
var Secs = 0.0

var Level
var timer

var Scores_t = [600,600,600,600]
var Scores_d = [99,99,99,99]

func _ready():
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)

func ready():
	if timer.is_stopped():
		timer.start(.01)
	if Saved == false:
		PlayerPos = $"/root/World/Player".global_position

func _on_timer_timeout():
	Secs += .01
	if Mins == 9 && Secs >= 59.98:
		timer.stop()
	if Secs >= 60.0:
		Secs = 0
		Mins += 1

func zero():
	if timer:
		timer.stop()
	Deaths = 0
	Secs = 0
	Mins = 0

func scene(name):
	G.Can = false
	get_tree().change_scene("res://scenes/levels/"+name+".tscn")
