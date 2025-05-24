extends Node2D

@onready var player = $Character
@onready var spawn_point = $SpawnPoint


func _ready() -> void:
	player.global_position = spawn_point.get_spawn_posotion()
