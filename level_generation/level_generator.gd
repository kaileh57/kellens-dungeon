extends Node2D




#Rooms sorted by prefab
const SPAWN_ROOMS = []
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

func generate_level():
	place_hub_room()
	


func place_hub_room():
	randomize()
	var room = HUB_ROOMS[randi() % HUB_ROOMS.size()].instantiate()
	rooms.add_child(room)
	room.name = "Hub"
