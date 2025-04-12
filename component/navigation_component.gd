extends Node

@export var ground: TileMapLayer

var astar_grid: AStarGrid2D

func _ready() -> void:
    astar_grid = AStarGrid2D.new()

    astar_grid.region = ground.get_used_rect()
    astar_grid.cell_size = ground.tile_set.tile_size

    match ground.tile_set.tile_shape:
        TileSet.TILE_SHAPE_SQUARE:
            astar_grid.cell_shape = AStarGrid2D.CELL_SHAPE_SQUARE
        TileSet.TILE_SHAPE_ISOMETRIC:
            astar_grid.cell_shape = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN
    
    # Initialize the grid with walkable cells
    _initialize_walkable_cells()

func _initialize_walkable_cells() -> void:
    # Mark all cells as walkable by default
    for x in range(astar_grid.region.position.x, astar_grid.region.end.x):
        for y in range(astar_grid.region.position.y, astar_grid.region.end.y):
            astar_grid.set_point_solid(Vector2i(x, y), false)

func calculate_path(start_pos: Vector2, end_pos: Vector2) -> PackedVector2Array:
    # Convert world positions to grid coordinates
    var start_cell = ground.local_to_map(start_pos)
    var end_cell = ground.local_to_map(end_pos)
    
    # Calculate path using AStarGrid2D
    var path = astar_grid.get_point_path(start_cell, end_cell)
    print(path)
    
    # Convert grid coordinates back to world positions
    var world_path: PackedVector2Array
    for point in path:
        world_path.append(ground.map_to_local(point))
    
    return world_path

    

