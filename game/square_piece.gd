extends Node2D

const tile_size: Vector2 = Vector2(32, 32)
var sprite_node_pos_tween : Tween

func _physics_process(delta: float) -> void:
    if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
        if Input.is_action_just_pressed("ui_up") and !$upright.is_colliding():
            _move(Vector2(1, -1))
        elif Input.is_action_just_pressed("ui_down") and !$downleft.is_colliding():
            _move(Vector2(-1, 1))
        elif Input.is_action_just_pressed("ui_left") and !$upleft.is_colliding():
            _move(Vector2(-1, -1))
        elif Input.is_action_just_pressed("ui_right") and !$downright.is_colliding():
            _move(Vector2(1, 1))

func _move(dir: Vector2) -> void:
    global_position += dir * tile_size
    $CharacterBody2D.global_position -= dir * tile_size

    if sprite_node_pos_tween:
        sprite_node_pos_tween.kill()
    sprite_node_pos_tween = create_tween()
    sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
    sprite_node_pos_tween.tween_property($CharacterBody2D, "global_position", global_position, 0.185).set_trans(Tween.TRANS_SINE)