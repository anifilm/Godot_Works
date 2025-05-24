extends CharacterBody2D

var gravity := 980
var speed := 200
var jump_force := 300

func _process(delta: float) -> void:
    velocity.y += gravity * delta

    var moveVector := Vector2.ZERO
    moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

    velocity.x = moveVector.x * speed

    if is_on_floor():
        if Input.is_action_just_pressed("ui_up"):
            velocity.y = -jump_force

    move_and_slide()
