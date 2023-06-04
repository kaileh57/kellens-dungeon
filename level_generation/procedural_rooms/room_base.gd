extends TileMap


@export var tile_size = 32
@export var room_w_min = 4
@export var room_h_min = 3
@export var room_w_max = 8
@export var room_h_max = 6
@export var room_comp_min = 1
@export var room_comp_max = 4

var room_w
var room_h
var room_comp

func _ready():
	generate_room(room_w_min,room_w_max,room_h_min,room_h_max, room_comp_min, room_comp_max)

func _input(_event):
	if Input.is_anything_pressed(): generate_room(room_w_min,room_w_max,room_h_min,room_h_max, room_comp_min, room_comp_max)

func generate_room(min_w, max_w, min_h, max_h, count_min, count_max):
	clear_layer(0)
	room_comp = randf_range(room_comp_min, room_comp_max)
	for i in room_comp:
		room_w = randf_range(room_w_min, room_w_max)
		room_h = randf_range(room_h_min, room_h_max)
		var room_start_x = randf_range(-4,4)
		var room_start_y = randf_range(-4,4)
		if i == 0:
			room_start_x = 0
			room_start_y = 0
		var cells = []
		for x in room_w:
			for y in room_h:
				cells.append(Vector2i(x+room_start_x,y+room_start_y))
		set_cells_terrain_connect(0,cells, 0, 0)

	
