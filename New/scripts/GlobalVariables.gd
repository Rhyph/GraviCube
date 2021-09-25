extends Node2D


var PlayerPos = Vector2(4, -4)

var Can = true
var Saved = false

var Popups = 0
var Mins = 0
var Secs = 0.0
var Cur_level = 7
var Level_count = 7

var Level = "Tutorial 1"

var timer

var Records_t = ["9:59.99","9:59.99","9:59.99","9:59.99","9:59.99","9:59.99","9:59.99"]
var Scores_t = [600,600,600,600,600,600,600]

var UI_sound = preload("res://scenes/UI/UIsound.tscn")

func _ready():
	var data = FS.load_data()
	if data:
		Cur_level = data["Current Level"]
		Scores_t = data["Time scores"]
		Records_t = data["Your best"]
	
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	
	if get_tree().current_scene.name != "Main Menu" && Saved == false:
		PlayerPos = $"/root/World/Player".global_position

func ready():
	if timer.is_stopped():
		timer.start(.01)

func _on_timer_timeout():
	Secs += .01
	if Mins == 9 && Secs >= 59.98:
		timer.stop()
	if Secs >= 60.0:
		Secs = 0
		Mins += 1

func zero():
	PlayerPos = Vector2(4, -4)
	if timer:
		timer.stop()
	Secs = 0
	Mins = 0

func reload_scene():
	zero()
	get_tree().reload_current_scene()

func scene(name):
	Can = false
	zero()
	get_tree().change_scene("res://scenes/levels/"+name+".tscn")

func music_mute():
	AudioServer.set_bus_mute(1, not AudioServer.is_bus_mute(1))
func FX_mute():
	AudioServer.set_bus_mute(2, not AudioServer.is_bus_mute(2))
func UIsound():
	var sound = UI_sound.instance()
	get_parent().add_child(sound)
