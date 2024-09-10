extends Node


var CupCakeScene = preload("res://Scenes/CupCake.tscn")


func _on_timer_timeout() -> void:
	var instanceCupCake = CupCakeScene.instantiate()
	instanceCupCake.position = Vector2(randi_range(380, 650), 0)
	add_child(instanceCupCake)
