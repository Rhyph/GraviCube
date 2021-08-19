extends Control


func _ready():
	if G.Cur_level != 1:
		$VBoxContainer/Start.text = "  Continue"
		$VBoxContainer/Levels.disabled = false
	if G.Cur_level > 1:
		$ColorRect/VBoxContainer2/Level2.disabled = false
	if G.Cur_level > 2:
		$ColorRect/VBoxContainer2/Level3.disabled = false
	if G.Cur_level > 3:
		$ColorRect/VBoxContainer2/Level4.disabled = false

var a = true
func _physics_process(delta):
	if a:
		instance_snow()
		a = false

func _on_Start_pressed():
	G.scene("Level" + str(G.Cur_level))
func _on_Levels_pressed():
	$ColorRect.visible = true
func _on_Quit_pressed():
	get_tree().quit()

func _on_Back_pressed():
	$ColorRect.visible = false

func _on_Level0_pressed():
	G.scene("Level1")
func _on_Level1_pressed():
	G.scene("Level2")
func _on_Level2_pressed():
	G.scene("Level3")
func _on_Level4_pressed():
	G.scene("Level4")

#Star instancing
const STAR = [preload("res://scenes/Space/Star1.tscn"), \
preload("res://scenes/Space/Star2.tscn"), preload("res://scenes/Space/Star3.tscn")]

var star = [0, 1, 2]

var rng = RandomNumberGenerator.new()
var rand

func _on_Star_timeout():
	$Star.start()
	rng.randomize()
	rand = rng.randi_range(0, 2)
	instance_star()

func instance_star():
	star[rand] = STAR[rand].instance()
	get_parent().add_child(star[rand])
	star[rand].position = $Position2D.global_position

#Snow instancing
const SNOW = preload("res://scenes/Snow.tscn")
const BIGSNOW = preload("res://scenes/BigSnow.tscn")

func instance_snow():
	var snow = SNOW.instance()
	get_parent().add_child(snow)
	snow.position = $Position2D2.global_position
	var bigsnow = BIGSNOW.instance()
	get_parent().add_child(bigsnow)
	bigsnow.position = $Position2D2.global_position
