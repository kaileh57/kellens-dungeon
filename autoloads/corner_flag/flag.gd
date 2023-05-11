extends CanvasLayer

###This script shows the little flag in the top left corner

func _ready():#shows or hides the correct flag for the build
	if $"/root/GlobalSettings".mode == 0:
		$Dev.show()
		$"/root/Debug".debug_print("Dev mode selected")
	else:
		$Dev.hide()
		
	if $"/root/GlobalSettings".mode == 1:
		$Experimental.show()
		$"/root/Debug".debug_print("$Experimental mode selected")
	else:
		$Experimental.hide()
