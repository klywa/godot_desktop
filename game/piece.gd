extends Area2D

@export var map: TileMapLayer

@onready var amplifier: HoverAmplifier = $HoverAmplifier
@onready var navigation_component := $NavigationComponent

var target_grid_position: Vector2i


func _ready() -> void:

    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)

    if map != null:
        set_map(map)

func set_map(map_in: TileMapLayer) -> void:
    map = map_in
    navigation_component.set_map(map)

func _on_mouse_entered() -> void:
    print("mouse entered")
    amplifier.amplify()

func _on_mouse_exited() -> void:
    print("mouse exited")
    amplifier.deamplify()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        print("left mouse button pressed")
        # print the position of the mouse
        print(get_global_mouse_position())

        var start_pos = map.local_to_map(to_local(global_position))
        var end_pos = map.local_to_map(to_local(get_global_mouse_position()))

        print("start_pos", start_pos)
        print("end_pos", end_pos)

        var id_path = navigation_component.get_id_path(start_pos, end_pos)
        print("id_path", id_path)



func move() -> void:
    print("move")
    # If no target or already at target, pick a new random position
    var current_grid_pos = map.local_to_map(global_position)
    print("current_grid_pos", current_grid_pos)
    
    if target_grid_position == null or current_grid_pos == target_grid_position:
        # get all tiles in the map and randomly pick one, other than the current position
        var tiles = map.get_used_cells_by_id(0)
        tiles.erase(current_grid_pos)
        target_grid_position = tiles[randi() % tiles.size()]
        print("new target", target_grid_position)
        draw_line_to_target()


func draw_line_to_target() -> void:
    if target_grid_position:
        var start_pos = global_position
        var end_pos = map.map_to_local(target_grid_position)
        var line = Line2D.new()
        line.points = [start_pos, end_pos]
        add_child(line)