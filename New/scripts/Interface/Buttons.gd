extends Node2D


func _on_TouchScreenButtonLeft_pressed():
	Input.action_press("ui_left")
func _on_TouchScreenButtonLeft_released():
	Input.action_release("ui_left")

func _on_TouchScreenButtonRight_pressed():
	Input.action_press("ui_right")
func _on_TouchScreenButtonRight_released():
	Input.action_release("ui_right")
