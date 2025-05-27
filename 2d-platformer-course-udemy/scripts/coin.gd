extends Node2D


func _ready() -> void:
	$Area2D.connect("area_entered", Callable(self, "_on_area_2d_entered"))


func _on_area_2d_entered(_area: Area2D) -> void:
	$AnimationPlayer.play("pickup")
	$Area2D.get_node("CollisionShape2D").set_deferred("disabled", true)
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))


func _on_animation_finished(_anim_name: String) -> void:
	$Area2D.queue_free()
