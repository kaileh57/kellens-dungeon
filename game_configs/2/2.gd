extends Control

@onready var viewport2 = $SubViewportContainer2/SubViewport
@onready var viewport1 = $SubViewportContainer/SubViewport
@onready var camera2 = $SubViewportContainer2/SubViewport/Camera2D
@onready var camera1 = $SubViewportContainer/SubViewport/Camera2D
@onready var world = $SubViewportContainer/SubViewport/Base

func _ready():
	viewport2.world_2d = viewport1.world_2d
	camera1.target = world.player1
	camera2.target = world.player2
	
	
