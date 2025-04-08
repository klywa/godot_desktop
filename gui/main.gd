extends Control

@onready var switch_button: Button = $Panel/AnimatedSprite2D/Button
@onready var anim_sprite := $Panel/AnimatedSprite2D

var is_playing := true

func _ready():
    switch_button.pressed.connect(on_switch_button_pressed)


func on_switch_button_pressed():
    is_playing = !is_playing
    if is_playing:
        anim_sprite.play()
    else:
        anim_sprite.pause()
