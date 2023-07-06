extends VBoxContainer

###This script manages some of the title screen buttons so their labels stay in sync with their textures


@onready var start_text = $Start/Label
@onready var multiplayer_text = $Multiplayer/Label
@onready var quit_text = $Quit/Label

#sanity code so the labels on the buttons acually go down
func _on_multiplayer_button_down():
	multiplayer_text.position.y = 3
func _on_multiplayer_button_up():
	multiplayer_text.position.y = 0
func _on_quit_button_down():
	quit_text.position.y = 3
func _on_quit_button_up():
	quit_text.position.y = 0
func _on_start_button_up():
	start_text.position.y = 0
func _on_start_button_down():
	start_text.position.y = 3
