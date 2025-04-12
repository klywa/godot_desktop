extends Node

var astar_grid: AStarGrid2D
var map: TileMapLayer

func set_map(map_in: TileMapLayer) -> void:
    map = map_in
    astar_grid = AStarGrid2D.new()
    astar_grid.region = map.get_used_rect()
    astar_grid.cell_size = map.tile_set.tile_size
    astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER

    match map.tile_set.tile_shape:
        TileSet.TILE_SHAPE_SQUARE:
            astar_grid.cell_shape = AStarGrid2D.CELL_SHAPE_SQUARE
        TileSet.TILE_SHAPE_ISOMETRIC:
            astar_grid.cell_shape = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN

    astar_grid.update()



