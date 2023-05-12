


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
		enable_blue()
	if unlocked.contains("green"):
		enable_green()
	if unlocked.contains("green"):
		pass



# Utility functions to enable character buttons
func enable_red():
	$MenuBackground/Page1/HBoxContainer/Red.disabled = false
	$MenuBackground/Page1/HBoxContainer/Red/Label.text = "Red"
	$MenuBackground/Page1/HBoxContainer/Red/Label2.text = """A basic character with no abilities of effects.
	
	
	
	
	
	Easy"""	

func enable_blue():
	$MenuBackground/Page1/HBoxContainer/Blue.disabled = false
	$MenuBackground/Page1/HBoxContainer/Blue/Label.text = "Blue"
	$MenuBackground/Page1/HBoxContainer/Blue/Label2.text = """Blue can go fast and attack fast, he can't take very many hits.
	
	
	
	Easy"""

func enable_green():
	$MenuBackground/Page1/HBoxContainer/Green.disabled = false
	$MenuBackground/Page1/HBoxContainer/Green/Label.text = "Green"
	$MenuBackground/Page1/HBoxContainer/Green/Label2.text = """Green is very strong, but very slow.
	
	
	
	
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

func _on_blue_pressed():
	character_name = "blue"
	character_path = "res://characters/blue/blue.tscn"
	switch_scenes()

func _on_green_pressed():
	character_name = "green"
	character_path = "res://characters/green/green.tscn"
	switch_scenes()
