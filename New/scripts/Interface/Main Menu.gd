extends Control


func _ready():
	if G.Cur_level != 0:
		$VBoxContainer/Start.text = "  Continue"
	if G.Cur_level > 0:
		$ColorRect/VBoxContainer2/Level1.disabled = false
	if G.Cur_level > 1:
		$ColorRect/VBoxContainer2/Level2.disabled = false

func _on_Start_pressed():
	G.scene("Level" + str(G.Cur_level))
func _on_Levels_pressed():
	$ColorRect.visible = true
func _on_Quit_pressed():
	get_tree().quit()

func _on_Back_pressed():
	$ColorRect.visible = false

func _on_Level0_pressed():
	G.scene("Level0")
func _on_Level1_pressed():
	G.scene("Level1")
func _on_Level2_pressed():
	G.scene("Level2")
func _on_Level3_pressed():
	G.scene("Level3")

#Star inscancing
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
