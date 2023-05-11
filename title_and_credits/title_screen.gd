extends Node

###This script manages the title screen


#makes all the buttons work

func _on_quit_pressed():
	get_tree().quit()


func _on_start_pressed():#fade the screen
	$CanvasLayer/Fade.fade()

func fade():
	get_tree().change_scene_to_file("res://characters/selector/character_selector.tscn")






