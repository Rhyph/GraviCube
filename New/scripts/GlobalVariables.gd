extends Node2D


var level = "World"

var PlayerPos = Vector2()

var can = true
var Laved = false
var saved = false
var GraviSwitch = true #false

var Deaths = 0

func _ready():
	if saved == false:
		PlayerPos = $"/root/World/Player".global_position

func scene(name):
	Deaths = 0
	get_tree().change_scene("res://scenes/levels/"+name+".tscn")
