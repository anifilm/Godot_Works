extends Control


@onready var score = $Label


func _process(_delta: float) -> void:
	score.text = "Score: " + str(Global.Score)
