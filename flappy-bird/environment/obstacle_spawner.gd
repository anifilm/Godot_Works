extends Node2D

signal obstacle_created(obs)

@onready var timer = $Timer

var Obstacle = preload("res://environment/obstacle.tscn")

func _ready():
	randomize()

func _on_timer_timeout() -> void:
	spawn_obstacle()

func spawn_obstacle():
	var obstacle = Obstacle.instantiate()
	add_child(obstacle)
	obstacle.position.x = randi() % 100 + 50
	obstacle.position.y = randi() % 330 + 170 # get random number between 170~500
	emit_signal("obstacle_created", obstacle)

func start():
	timer.start()

func stop():
	timer.stop()
