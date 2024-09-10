extends CharacterBody2D


const MoveSpeed = 400


func _physics_process(_delta: float) -> void:
	# 키보드 누를 때
	if Input.is_action_pressed("Up"):
		velocity.y = -MoveSpeed
	if Input.is_action_pressed("Down"):
		velocity.y = MoveSpeed
	if Input.is_action_pressed("Left"):
		velocity.x = -MoveSpeed
	if Input.is_action_pressed("Right"):
		velocity.x = MoveSpeed
	# 키보드 땔 때
	if Input.is_action_just_released("Up"):
		velocity.y = 0
	if Input.is_action_just_released("Down"):
		velocity.y = 0
	if Input.is_action_just_released("Left"):
		velocity.x = 0
	if Input.is_action_just_released("Right"):
		velocity.x = 0

	# 도로 밖을 벗어나지 못하게 막기
	if position.x < 380:
		position.x = 380
	elif position.x > 650:
		position.x = 650

	if position.y < 33:
		position.y = 33
	elif position.y > 990:
		position.y = 990

	move_and_slide()
