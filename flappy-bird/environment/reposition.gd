extends Sprite2D

@export var reset_position = 460
@export var move_speed = 100

func _process(delta: float) -> void:
	global_position.x += -move_speed * delta
	if global_position.x <= -reset_position:
		global_position.x = reset_position
