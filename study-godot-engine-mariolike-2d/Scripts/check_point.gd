extends StaticBody2D

@onready var sprite = $Flag
@onready var checkpoint = $CheckArea
@export var checkpoint_state = false


func _on_check_area_body_entered(body:Node2D) -> void:
    if checkpoint_state == false and body.name == "Character":
        checkpoint_state = true
        sprite.play("flagin")
        checkpoint.queue_free()

func _on_flag_animation_finished() -> void:
    if checkpoint_state == true:
        sprite.play("flagon")
