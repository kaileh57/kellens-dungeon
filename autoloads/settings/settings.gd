extends CanvasLayer


func _process(delta):
	if Input.is_action_pressed("pause"):
		show()
	else: 
		hide()



func _on_check_button_toggled(button_pressed):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, button_pressed)
