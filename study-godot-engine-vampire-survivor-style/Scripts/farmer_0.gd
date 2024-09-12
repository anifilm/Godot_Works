extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func play_idle_animation():
    animated_sprite.play("Stand")

func play_walk_animation():
    animated_sprite.play("Run")
