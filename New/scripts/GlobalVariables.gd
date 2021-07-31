extends Node2D


var level = "World"

var PlayerPos = Vector2()

var can = true
var Laved = false
var saved = false
var GraviSwitch = true #false

var Deaths = 0
var secs = 0.0
var mins = 0

func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.start(.01)
	if saved == false:
		PlayerPos = $"/root/World/Player".global_position

func _on_timer_timeout():
	secs += .01
	if secs >= 60.0:
		secs = 0
		mins += 1

func scene(name):
	Deaths = 0
	get_tree().change_scene("res://scenes/levels/"+name+".tscn")
