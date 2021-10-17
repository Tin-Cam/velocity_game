extends Camera2D

func _ready():
	#_auto_set_limits()
	pass

func _auto_set_limits():
	limit_left = 0
	limit_right = 0
	limit_bottom = 0
	
	var tilemaps = get_tree().get_nodes_in_group("tile_map")
	for tilemap in tilemaps:
		var used = tilemap.get_used_rect()
		limit_left = min(used.position.x * tilemap.cell_size.x, limit_left)
		limit_right = max(used.end.x * tilemap.cell_size.x, limit_right)
		limit_bottom = max(used.end.y * tilemap.cell_size.y, limit_bottom)
