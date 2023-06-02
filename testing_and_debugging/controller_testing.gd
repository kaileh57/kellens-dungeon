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
