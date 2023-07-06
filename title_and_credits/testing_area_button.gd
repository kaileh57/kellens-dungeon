extends Button

###This script opens the testing area if a developer presses the testing button

func  _ready():
	if $"/root/GlobalSettings".mode == 0: show()
	else: hide()

func _on_pressed():#switch to the testing area
	pass
