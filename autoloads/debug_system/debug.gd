extends Node

###This script is used for debugging, if you want to have something in the console long term, use
###debug_print because that will be changed to the in-game console when thats done

@onready var in_engine_debug: bool = $"/root/GlobalSettings".mode == 0

func _ready():
	debug_print("debug ready")
	$"/root/GlobalSettings".boot()
	

func debug_print(message):#default debug system, designed to be changed in the future
	if in_engine_debug == true:
		print(message)

