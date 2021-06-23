extends Sprite




var k = 0

func _physics_process(delta):
	if $TouchScreenButton2.modulate == Color(0, 0, 0, 0):
		if k % 2 != 0:
			k = 2

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			position = event.position
			$TouchScreenButton2._on_TouchScreenButton_pressed()

func _on_Area2D2_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		k += 1
	
	if k % 2 == 0 and k != 0:
		$TouchScreenButton2._on_TouchScreenButton_released()
