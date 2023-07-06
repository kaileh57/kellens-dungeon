extends TileMap

var rng = RandomNumberGenerator.new()



func _process(delta):
	$Camera2D/Label.text = str(Engine.get_frames_per_second())

func _on_spread_timeout():
	if Input.is_action_pressed("1"):
		for tile in get_used_cells_by_id(0,0):
			var dir = rng.randi_range(1, 4)
			if dir == 1:
				set_cell(0, tile+Vector2i.DOWN,0,Vector2i(0,0))
			elif dir == 2:
				set_cell(0, tile+Vector2i.UP,0,Vector2i(0,0))
			elif dir == 3:
				set_cell(0, tile+Vector2i.LEFT,0,Vector2i(0,0))
			elif dir == 4:
				set_cell(0, tile+Vector2i.RIGHT,0,Vector2i(0,0))
			

