extends Button



func _ready():#shows the button only in dev mode
	if $"/root/GlobalSettings".mode == 0: self.show()
	$"/root/GlobalSettings".testing = self.button_pressed


func _on_toggled(_button_pressed):#go to the testing scene when enabled
	$"/root/GlobalSettings".testing = _button_pressed
