extends Node2D

signal score

@onready var point = $Point

@export var move_speed = 200

func _physics_process(delta: float) -> void:
	position.x += -move_speed * delta
	if global_position.x <= -200:
		queue_free()

func _on_score_area_body_exited(body: Node2D) -> void:
	if body is Player:
		point.play()
		emit_signal("score")

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("die"):
			body.die()
