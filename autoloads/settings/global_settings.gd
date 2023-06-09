extends Node

###This script manages all global settings and data as it's easier than trying to manage direct communication


#testing vars
var mode: int = 0 #used to set build mode, 0 for dev, 1 for experimental, 2 for stable build
@onready var debug = $"/root/Debug"

const game_path := "res://testing_and_debugging/testing.tscn"
@onready var game_instance = preload(game_path)
const test_path := "res://testing_and_debugging/testing.tscn"
@onready var test_instance = preload(test_path)



var testing = true

func boot():#util function to print selected settings
	debug.debug_print("selected variables:")
	debug.debug_print("mode: " + str(mode))
	debug.debug_print("game path: " + str(game_path))
	debug.debug_print("test path: " + str(test_path))

var character_path


#game vars
var difficulty: String
var player_list := []
