extends ParallaxBackground


const ScrollSpeed = 200


func _process(delta: float) -> void:
	scroll_offset.y += ScrollSpeed * delta
