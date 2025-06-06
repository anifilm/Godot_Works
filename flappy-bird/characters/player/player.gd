extends RigidBody2D
class_name Player

signal died

var FLAP_FORCE = -500
const MAX_ROTATION_DEGREES = -25.0
const MAX_MOVE_HEIGHT = -10

@onready var animator = $AnimationPlayer
@onready var hit = $Hit
@onready var wing = $Wing
@onready var dead = $Die

var started = false
var alive = true


func _physics_process(_delta: float) -> void:
	if alive && Input.is_action_just_pressed("flap"):
		if !started:
			start()
		flap()

	if global_position.y <= MAX_MOVE_HEIGHT:
		global_position.y = MAX_MOVE_HEIGHT 
		
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES

	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 2
		else:
			angular_velocity = 0

func start():
	if started: return
	started = true
	gravity_scale = 1.2
	animator.play("flap")

func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -12.0
	wing.play()

func die():
	if !alive: return
	alive = false
	animator.stop()
	hit.play()
	dead.play()
	emit_signal("died")
