


### Selector for player character




extends Control

@export var path = "res://characters/unlocked/unlocked.txt"
var page := 1




var default := false
var teal := false

func _ready():
	load_chars()
	$ColorRect.show()
	$ColorRect/AnimationPlayer.play("fade")


# Load which characters are unlocked from txt file
func load_chars():
	var unlocked = FileAccess.open(path,FileAccess.READ).get_as_text()
	if unlocked.contains("default"):
		default = true
		$MenuBackground/Page1/HBoxContainer/VBoxContainer/Default.disabled = false
	if unlocked.contains("teal"):
		teal = true
		$MenuBackground/Page1/HBoxContainer/VBoxContainer2/Teal.disabled = false
	if unlocked.contains("green"):
		pass#enable_green()
	if unlocked.contains("yellow"):
		pass#enable_yellow()
	if unlocked.contains("purple"):
		pass#enable_purple()




func switch_scenes(character_name,character_path):
	$"/root/GlobalSettings".character_name = character_name
	$"/root/GlobalSettings".character_path = character_path
	$ColorRect/AnimationPlayer.play_backwards("fade")
	await get_tree().create_timer(0.3).timeout
	if $"/root/GlobalSettings".testing == true:get_tree().change_scene_to_file($"/root/GlobalSettings".test_path)
	elif $"/root/GlobalSettings".testing == false:get_tree().change_scene_to_file($"/root/GlobalSettings".game_path)

func show_bottom(title:String, flavor: String):
	$MenuBackground/BottomText/MarginContainer/VBoxContainer/Title.text = title
	$MenuBackground/BottomText/MarginContainer/VBoxContainer/Flavor.text = flavor
	$MenuBackground/BottomText.show()

func hide_bottom():
	$MenuBackground/BottomText.hide()


func _on_default_mouse_entered():
	if default:
		show_bottom("Default","Basic, uninteresting, and default. A good choice for new players. [No abilities]")
	else:
		show_bottom("???",str("                      ????" + "\n" + "                      ????" + "\n" + "                      ????" + "\n" + "                      ????"))

func _on_teal_mouse_entered():
	if teal:
		show_bottom("Teal [Santi]","A truly speedy lad. His lack of attentiveness can lead to a quick death. Also enjoys stabbing")
	else:
		show_bottom("???",str("                      ????" + "\n" + "                      ????" + "\n" + "                      ????" + "\n" + "                      ????"))


func _on_default_pressed():
	switch_scenes("default","res://characters/default/default.tscn")


func _on_teal_pressed():
	switch_scenes("teal","res://characters/teal/teal.tscn")



