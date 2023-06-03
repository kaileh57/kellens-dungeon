extends Node2D

@onready var world = $Master/SubViewport/Base
@onready var camera1 = $Container1/SubViewport/Camera2D
@onready var camera2 = $Container2/SubViewport/Camera2D
@onready var master_viewport = $Master/SubViewport
@onready var viewport1 = $Container1/SubViewport
@onready var viewport2 = $Container2/SubViewport


func _ready():
	if $"/root/GlobalSettings".testing == true: master_viewport.add_child($"/root/GlobalSettings".test_path.instantiate())
	elif $"/root/GlobalSettings".testing == false: master_viewport.add_child($"/root/GlobalSettings".game_path.instantiate())
	viewport1.world_2d = master_viewport.world_2d
	viewport2.world_2d = master_viewport.world_2d
	camera1.target = world.player1
	camera2.target = world.player2
