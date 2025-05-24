extends Control


func _on_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")
