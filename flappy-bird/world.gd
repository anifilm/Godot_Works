extends Node2D

@onready var hud = $HUD
@onready var menu_layer = $MenuLayer
@onready var obstacle_spawner = $ObstacleSpawner
@onready var player = $Player
@onready var ground = $Ground

const SAVE_FILE_PATH = "user://savedata.save"

var highscore = 0
var score = 0 : set = _set_score, get = _get_score

func _set_score(new_score):
	score = new_score
	hud.update_score(score)

func _get_score():
	return score

func _ready():
	obstacle_spawner.connect("obstacle_created", Callable(self, "_on_obstacle_created"))
	load_highscore()

func _on_menu_layer_start_game() -> void:
	new_game()

func new_game():
	score = 0
	player.visible = true
	hud.visible = true
	obstacle_spawner.start()

func player_score():
	score += 1

func _on_obstacle_created(obs):
	obs.connect("score", Callable(self, "player_score"))

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_player_died() -> void:
	game_over()
	
func game_over():
	obstacle_spawner.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	get_tree().call_group("move_bg", "set_process", false)

	if score > highscore:
		highscore = score
		save_highscore()
		
	menu_layer.init_game_over_menu(score, highscore)

func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if save_data:
		var data = {
			"highscore": highscore
		}
		var json_string = JSON.stringify(data)
		save_data.store_string(json_string)
		#print("하이스코어를 저장하였습니다: ", json_string)
		save_data.close()
	else:
		push_error("하이스코어 저장 실패: 파일 열기 실패")

func load_highscore():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if save_data:
			var content = save_data.get_as_text()
			save_data.close()
			var result = JSON.parse_string(content)
			if result is Dictionary and result.has("highscore"):
				highscore = int(result["highscore"])
				#print("하이스코어를 불러왔습니다: ", highscore)
			else:
				highscore = 0
				#print("하이스코어를 불러올 수 없습니다. 값을 초기화합니다.")
		else:
			push_error("하이스코어 파일 읽기 실패")
	else:
		print("하이스코어 파일이 없습니다. 초기화됨")
		highscore = 0
