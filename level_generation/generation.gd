extends Node2D
class_name generate

###This script manages level generation


#this class is going to be commented to a much higher standard than all others as it's very confusing,
#also very much not done yet



#define generation variables
@export var target_rooms := 15
var tile_size := 16
@onready var map_size := target_rooms * 4
var placed_rooms := 0

#room paths
var starting_rooms := [preload("res://rooms/default/start/start_1.tscn")]
var middle_rooms := [preload("res://rooms/default/mid/mid_1.tscn")]
var end_rooms := [preload("res://rooms/default/end/end_1.tscn")]

#
var rng = RandomNumberGenerator.new()
@onready var rooms = $Rooms

#calculate generation parameters


func _ready():
	place_starting_room()
	place_mid_rooms()

func place_starting_room():
	randomize()
	var room = starting_rooms[randi() % starting_rooms.size()].instantiate()
	rooms.add_child(room)
	room.name = "Start"


func place_mid_rooms():
	for i in target_rooms:
		randomize()
		var room = middle_rooms[randi() % middle_rooms.size()].instantiate()
		rooms.add_child(room)
		room.name = "Mid"
		room.position.x = randf_range(-map_size, map_size) * tile_size
		room.position.y = randf_range(-map_size, map_size) * tile_size
		room.place(map_size, tile_size)

