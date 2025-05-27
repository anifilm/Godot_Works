extends CharacterBody2D

var gravity := 980
var speed := 120
var acceleration := 300
var jump_force := 400
var jump_termination_multiplier = 3

func _process(delta: float) -> void:
	var moveVector := Vector2.ZERO
	moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	moveVector.y = -1 if Input.is_action_just_pressed("ui_up") else 0
	
	velocity.x += moveVector.x * acceleration * delta
	if (moveVector.x == 0):
		velocity.x = lerp(.0, velocity.x, pow(2, -40 * delta))

	velocity.x = clamp(velocity.x, -speed, speed)
		
	if (moveVector.y < 0 && is_on_floor()):
		velocity.y = moveVector.y * jump_force
		
	if (velocity.y < 0 && !Input.is_action_pressed("ui_up")):
		velocity.y += gravity * jump_termination_multiplier * delta
	else:
		velocity.y += gravity * delta

	move_and_slide()
