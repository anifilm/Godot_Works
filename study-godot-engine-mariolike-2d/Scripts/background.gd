extends ParallaxBackground


@export var backgroundImage:CompressedTexture2D
@export var scrollSpeedX = 10
@export var scrollSpeedY = 10
@onready var sprite = $ParallaxLayer/Sprite2D


func _ready() -> void:
	sprite.texture = backgroundImage


func _process(delta: float) -> void:
	sprite.region_rect.position += Vector2(scrollSpeedX, scrollSpeedY) * delta
	if sprite.region_rect.position.x >= 1024 || sprite.region_rect.position.y >= 1024:
		sprite.region_rect.position = Vector2.ZERO
	if sprite.region_rect.position.x <= -1024 || sprite.region_rect.position.y <= -1024:
		sprite.region_rect.position = Vector2.ZERO
