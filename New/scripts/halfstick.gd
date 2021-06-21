extends Sprite




var k = 0

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			position = event.position
			$TouchScreenButton2._on_TouchScreenButton_pressed()

func _on_Area2D2_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		k += 1
	
	if k % 2 == 0:
		$TouchScreenButton2._on_TouchScreenButton_released()

func _on_Area2D3_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if k % 2 != 0:
			k += 1
