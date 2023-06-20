extends Node2D
class_name generate

###This script manages level generation


#this class is going to be commented to a much higher standard than all others as it's very confusing,
#also very much not done yet



#define generation variables
@export var target_rooms := 15
var placed_rooms := 0

#room paths
var starting_rooms := [preload("res://rooms/default/start/start_1.tscn")]
var middle_rooms := [preload("res://rooms/default/mid/mid_1.tscn")]
var end_rooms := [preload("res://rooms/default/end/end_1.tscn")]
var vert_hallways := [preload("res://rooms/default/hallway/up_down/ud_1.tscn")]
var horz_hallways := [preload("res://rooms/default/hallway/left_right/lr_1.tscn")]
#hallway caps
var up_cap := [preload("res://rooms/default/cap/upcap_1.tscn")]
var down_cap := [preload("res://rooms/default/cap/downcap_1.tscn")]
var left_cap := [preload("res://rooms/default/cap/leftcap_1.tscn")]
var right_cap := [preload("res://rooms/default/cap/rightcap_1.tscn")]
#
var rng = RandomNumberGenerator.new()
@onready var rooms = $Rooms

#calculate generation parameters


func _ready():
	#place_starting_room()
	generate_tick()

func place_starting_room():
	randomize()
	var room = starting_rooms[randi() % starting_rooms.size()].instantiate()
	rooms.add_child(room)
	room.name = "Start"


func generate_tick():
	var points := 0
	for room in rooms.get_children():
		for point in room.find_child("Connectors").get_children():
			if point != null:
				randomize()
				points += 1
				if rng.randi() % 4 == 0: 
					cap(point, point.name)
					point.queue_free()
				elif "Hallway" not in room.name:
					place_hallway(point, point.name)
				else:
					place_room(point, point.name)
	#if points != 0: generate_tick()
	

func cap(location: Marker2D, direction: String):
	var room
	var reverse_direction: String
	randomize()
	if direction == "Up": room = up_cap[randi() % up_cap.size()].instantiate(); reverse_direction = "Down"
	elif direction == "Down": room = down_cap[randi() % down_cap.size()].instantiate(); reverse_direction = "Up"
	elif direction == "Left": room = left_cap[randi() % left_cap.size()].instantiate(); reverse_direction = "Right"
	elif direction == "Right": room = right_cap[randi() % right_cap.size()].instantiate(); reverse_direction = "Left"
	rooms.add_child(room)
	var connector = room.find_child(reverse_direction)
	room.global_position = location.global_position + connector.position * -1
	room.name = "Cap"
	connector.queue_free()

func place_hallway(location: Marker2D, direction: String):
	var room
	var reverse_direction: String
	if direction == "Up": room = vert_hallways[randi() % vert_hallways.size()].instantiate(); reverse_direction = "Up"
	elif direction == "Down": room = vert_hallways[randi() % vert_hallways.size()].instantiate(); reverse_direction = "Down"
	elif direction == "Left": room = horz_hallways[randi() % horz_hallways.size()].instantiate(); reverse_direction = "Right"
	elif direction == "Right": room = horz_hallways[randi() % horz_hallways.size()].instantiate(); reverse_direction = "Left"
	rooms.add_child(room)
	var connector = room.find_child(reverse_direction)
	room.global_position = location.global_position + connector.position * -1
	room.name = "Hallway"
	connector.queue_free()

func place_room(location: Marker2D, direction: String):
	pass



