extends Camera2D

var target_position := Vector2.ZERO

@export var background_color: Color


func _ready() -> void:
	RenderingServer.set_default_clear_color(background_color)


func _process(delta: float) -> void:
	acquire_target_position()
	global_position = lerp(target_position, global_position, pow(2, -15 * delta))


func acquire_target_position() -> void:
	var target_player := get_tree().get_nodes_in_group("player")
	if target_player.size() > 0:
		var player := target_player[0]
		target_position = player.global_position
