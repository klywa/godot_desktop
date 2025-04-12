extends Node
class_name GridMoveComponent

@export var piece: Node2D
@export var tile_step : = 32

@onready var upleft : RayCast2D = $upleft
@onready var upright : RayCast2D = $upright
@onready var downleft : RayCast2D = $downleft
@onready var downright : RayCast2D = $downright

var sprite_node_pos_tween : Tween
var tile_size: Vector2 


func _ready() -> void:
	tile_size = Vector2(tile_step, tile_step)

	upleft.target_position = Vector2(-tile_size.x / 4, -tile_size.y / 4)
	upleft.position = Vector2(-tile_size.x / 4, -tile_size.y / 4)
	upright.target_position = Vector2(tile_size.x / 4, -tile_size.y / 4)
	upright.position = Vector2(tile_size.x / 4, -tile_size.y / 4)
	downleft.target_position = Vector2(-tile_size.x / 4, tile_size.y / 4)
	downleft.position = Vector2(-tile_size.x / 4, tile_size.y / 4)
	downright.target_position = Vector2(tile_size.x / 4, tile_size.y / 4)
	downright.position = Vector2(tile_size.x / 4, tile_size.y / 4)

func _physics_process(delta: float) -> void:
	if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
		if Input.is_action_just_pressed("ui_up") and !upright.is_colliding():
			_move(Vector2(1, -1))
		elif Input.is_action_just_pressed("ui_down") and !downleft.is_colliding():
			_move(Vector2(-1, 1))
		elif Input.is_action_just_pressed("ui_left") and !upleft.is_colliding():
			_move(Vector2(-1, -1))
		elif Input.is_action_just_pressed("ui_right") and !downright.is_colliding():
			_move(Vector2(1, 1))

func _move(dir: Vector2) -> void:
	var tmp_global_position := piece.global_position + dir * tile_size

	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property(piece, "global_position", tmp_global_position, 0.185).set_trans(Tween.TRANS_SINE)
