extends Node
class_name HoverAmplifier

@export var entity : Node2D
@export var scale_factor : float = 1.2

var tween : Tween
var origin_scale : Vector2

func amplify() -> void:
    if tween:
        tween.kill()
    tween = create_tween()
    origin_scale = entity.scale
    tween.tween_property(entity, "scale", entity.scale * scale_factor, 0.1).set_trans(Tween.TRANS_BOUNCE)


func deamplify() -> void:
    if tween:
        tween.kill()
    tween = create_tween()
    tween.tween_property(entity, "scale", origin_scale, 0.1).set_trans(Tween.TRANS_BOUNCE)
