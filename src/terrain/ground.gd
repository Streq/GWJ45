extends TileMap

func drill_tile(tile:Vector2):
	set_cellv(tile, -1)
	update_bitmask_area(tile)
