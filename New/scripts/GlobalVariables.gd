extends Node2D




var level = "World"
var can = true
var GraviSwitch = true #false
var PlayerPos = Vector2()
var saved = false

func _ready():
	if saved == false:
		PlayerPos = $"/root/World/Player".global_position
