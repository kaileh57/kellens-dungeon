extends Node2D


var player1
var player2

# spawn in the correct character
func _ready():
		var character = ResourceLoader.load("res://characters/default/default.tscn").instantiate()#ResourceLoader.load($"/root/GlobalSettings".character_path).instantiate()
		$Players.add_child(character)
		character.name = "player1"
		character.assigned_control_set = 1
		#FOR JUST ONE
		#character.camera.enabled = true
		
		#FOR TWO PLAYERS
		var character2 = ResourceLoader.load("res://characters/default/default.tscn").instantiate()#$"/root/GlobalSettings".character_path).instantiate()
		$Players.add_child(character2)
		character2.name = "player2"
		character2.assigned_control_set = 2
		character2.position.x += 40
		player1 = character
		player2 = character2
		character.assign()
		character2.assign()
		
		
