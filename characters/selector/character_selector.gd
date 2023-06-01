


### Selector for player character




extends Control

@export var path = "res://characters/unlocked/unlocked.txt"
var page := 1


var character_name
var character_path


func _ready():
	load_chars()
	$ColorRect/AnimationPlayer.play("fade")


# Load which characters are unlocked from txt file
func load_chars():
	var unlocked = FileAccess.open(path,FileAccess.READ).get_as_text()
	if unlocked.contains("red"):
		enable_red()
	if unlocked.contains("blue"):
		pass#enable_blue()
	if unlocked.contains("green"):
		pass#enable_green()
	if unlocked.contains("yellow"):
		pass#enable_yellow()
	if unlocked.contains("purple"):
		pass#enable_purple()



# Utility functions to enable character buttons
func enable_red():
	$MenuBackground/Page1/HBoxContainer/Red.disabled = false
	$MenuBackground/Page1/HBoxContainer/Red/Label.text = "Red"
	$MenuBackground/Page1/HBoxContainer/Red/Label2.text = """A basic character with no abilities of effects.
	
	
	
	
	
	Easy"""	

	
	
	


func switch_scenes():
	$"/root/GlobalSettings".character_name = character_name
	$"/root/GlobalSettings".character_path = character_path
	$ColorRect/AnimationPlayer.play_backwards("fade")
	await get_tree().create_timer(0.3).timeout
	if $"/root/GlobalSettings".testing == true:get_tree().change_scene_to_file($"/root/GlobalSettings".test_path)
	elif $"/root/GlobalSettings".testing == false:get_tree().change_scene_to_file($"/root/GlobalSettings".game_path)

func _on_red_pressed():
	character_name = "red"
	character_path = "res://characters/red/red.tscn"
	switch_scenes()

func show_bottom(tooltip: String):
	$MenuBackground/BottomText/Label.text = tooltip
	$MenuBackground/BottomText.show()

func hide_bottom():
	$MenuBackground/BottomText.hide()


func _on_red_mouse_entered():
	if $MenuBackground/Page1/HBoxContainer/Red/Label.text == "Red":
		show_bottom("""Basic, uninteresting, and default.
		
		EASY""")



