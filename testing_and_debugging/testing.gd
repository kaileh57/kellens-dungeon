extends Node2D



# spawn in the correct character
func _ready():
		var character = ResourceLoader.load($"/root/GlobalSettings".character_path).instantiate()
		$Characters.add_child(character)
		character.name = $"/root/GlobalSettings".character_name
		character = ResourceLoader.load("res://characters/blue/blue.tscn").instantiate()
		$Characters.add_child(character)
		character.name = $"/root/GlobalSettings".character_name
		character = ResourceLoader.load("res://characters/green/green.tscn").instantiate()
		$Characters.add_child(character)
		character.name = $"/root/GlobalSettings".character_name

