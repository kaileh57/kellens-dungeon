extends Node
class_name FSM


###This script  is a finite state machine class to manage character and enemy animations and behavior


var state: String = ""
var old_state: String = ""

#grab hold of all the nodes we'll need
@onready var parent: CharacterBase = get_parent()

# finite state machine functions
func set_state(new_state: String):
	old_state = state
	state = new_state
