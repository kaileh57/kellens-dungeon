extends Node2D

func _input(event):
	if Input.is_action_pressed("test0"): 
		$ColorRect3.show()
	else: $ColorRect3.hide()
	if Input.is_action_pressed("test1"): 
		$ColorRect.show()
	else: $ColorRect.hide()
	if Input.is_action_pressed("test2"): 
		$ColorRect2.show()
	else: $ColorRect2.hide()
	if Input.is_action_just_pressed("shake all"): Input.start_joy_vibration(0,1,0,0.5)
	if Input.is_action_just_pressed("shak 2"): Input.start_joy_vibration(0,0,1,0.5)
