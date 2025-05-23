extends CanvasLayer

signal start_game

@onready var start_message = $StartMenu/StartMessage
@onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
@onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel
@onready var game_over_menu = $GameOverMenu

var game_started = false

func _input(event):
	if !game_started && event.is_action_pressed("flap"):
		emit_signal("start_game")
		var start_color = start_message.modulate
		var target_color = Color(start_color.r, start_color.g, start_color.b, 0.0)
		var tween = create_tween()
		tween.tween_property(start_message, "modulate", target_color, 0.3)
		game_started = true

func init_game_over_menu(score, highscore):
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "BEST: " + str(highscore)
	game_over_menu.visible = true

func _on_restart_button_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
