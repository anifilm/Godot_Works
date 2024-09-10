extends Area2D


const ScrollSpeed = 200


func _process(delta: float) -> void:
	position.y += ScrollSpeed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Car":
		Global.Score += 10
		print("Score: ", Global.Score)
		self.queue_free()
