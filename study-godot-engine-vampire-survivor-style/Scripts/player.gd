extends CharacterBody2D

var SPEED = 600

func _physics_process(_delta: float) -> void:
    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = direction * SPEED
    move_and_slide()

    if velocity.length() > 0.0:
        $Farmer0.play_walk_animation()
    else:
        $Farmer0.play_idle_animation()
