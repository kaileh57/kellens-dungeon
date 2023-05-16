extends Node2D



# spawn in the correct character
func _ready():
		var character = ResourceLoader.load($"/root/GlobalSettings".character_path).instantiate()
		$Players.add_child(character)
		character.name = $"/root/GlobalSettings".character_name
