extends Node2D




#Rooms sorted by prefab
const SPAWN_ROOMS = [preload("res://rooms/default/easy_rooms/easy1.tscn")]
const EASY_ROOMS = [preload("res://rooms/default/easy_rooms/easy1.tscn")]

const HUB_ROOMS = [preload("res://rooms/default/hub_rooms/hub1.tscn")]
const NORMAL_ROOMS = []
const LOOT_ROOMS = []

const HARD_ROOMS = []
const SHOP_ROOMS = []
const BOSS_ROOMS = []

#onready variables
@onready var rooms = $Rooms

#generation configuration settings
@export var has_boss := true
@export var hard_chance := 10
@export var loot_rooms := 2

#placement settings
var tile_size := 16
@export var hub_varience := 0
@export var spawn_varience := 20

func _ready():
	generate_level()

func generate_level():
	place_hub_room()
	place_spawn_room()


func place_hub_room():
	randomize()
	var room = HUB_ROOMS[randi() % HUB_ROOMS.size()].instantiate()
	print(room)
	rooms.add_child(room)
	room.position.x = randi_range(-hub_varience, hub_varience)*tile_size
	room.position.y = randi_range(-hub_varience, hub_varience)*tile_size
	room.name = "Hub"

func place_spawn_room():
	randomize()
	var room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instantiate()
	print(room)
	rooms.add_child(room)
	randomize()
	room.position.x = randi_range(-spawn_varience, spawn_varience)*tile_size
	room.position.y = randi_range(-spawn_varience, spawn_varience)*tile_size
	await get_tree().process_frame
	print(room.find_child("RoomShape").has_overlapping_areas())
	while room.find_child("RoomShape").has_overlapping_areas():
		randomize()
		room.position.x = randi_range(-spawn_varience, spawn_varience)*tile_size
		room.position.y = randi_range(-spawn_varience, spawn_varience)*tile_size
	room.name = "Spawn"
