extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var coyote_timer = $CoyoteTimer

var gravity := 980
var speed := 120
var acceleration := 300
var jump_force := 400
var jump_termination_multiplier = 3
var isDoubleJumping := false


func _process(delta: float) -> void:
	var moveVector = get_movement_vector()

	velocity.x += moveVector.x * acceleration * delta
	if moveVector.x == 0:
		velocity.x = lerp(.0, velocity.x, pow(2, -40 * delta))

	velocity.x = clamp(velocity.x, -speed, speed)

	if moveVector.y < 0 and (is_on_floor() or !coyote_timer.is_stopped() or isDoubleJumping):
		velocity.y = moveVector.y * jump_force

		if !is_on_floor() and coyote_timer.is_stopped():
			isDoubleJumping = false
		coyote_timer.stop()

	if velocity.y < 0 and !Input.is_action_pressed("ui_up"):
		velocity.y += gravity * jump_termination_multiplier * delta
	else:
		velocity.y += gravity * delta

	var was_on_floor = is_on_floor()

	move_and_slide()

	if was_on_floor and !is_on_floor():
		coyote_timer.start()

	if is_on_floor():
		isDoubleJumping = true

	update_animation()


func get_movement_vector():
	var moveVector := Vector2.ZERO
	moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	moveVector.y = -1 if Input.is_action_just_pressed("ui_up") else 0
	return moveVector


func update_animation():
	if is_on_floor():
		if velocity.x != 0:
			animation_player.play("run")
		else:
			animation_player.play("idle")
	else:
		if velocity.y < 0:
			animation_player.play("jump")

	if get_movement_vector() != Vector2.ZERO:
		animation_player.flip_h = true if get_movement_vector().x > 0 else false
