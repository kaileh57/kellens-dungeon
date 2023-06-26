extends TileMap



func place(map_size, tile_size):
	randomize()
	position.x = randi_range(-map_size, map_size) * tile_size
	position.y = randi_range(-map_size, map_size) * tile_size
	for i in get_parent().get_children():
			if i != self && position.distance_to(i.position) < 320.0:
				place(map_size, tile_size)
