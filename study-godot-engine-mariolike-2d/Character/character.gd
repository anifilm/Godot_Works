extends CharacterBody2D


@export var gravity = 980
@export var jumpSpeed = -400
@export var moveSpeed = 200
@onready var sprite = $AnimatedSprite2D

var is_jump = false
var is_wall = false

func _physics_process(delta: float) -> void:
	# 캐릭터가 바닥에 있고 점프 버튼을 눌렀을 때
	if is_on_floor() && Input.is_action_just_pressed("Jump"):
		velocity.y = jumpSpeed

	# 캐릭터가 벽에 있고 점프 버튼을 눌렀을 때
	if !is_on_floor() && is_on_wall() && Input.is_action_just_pressed("Jump"):
		velocity.y = jumpSpeed
		if sprite.flip_h:
			velocity.x = moveSpeed
		else:
			velocity.x = -moveSpeed
		sprite.flip_h = !sprite.flip_h

	# 캐릭터가 공중에 있고 점프 버튼을 눌렀을 때
	if !is_on_floor() && !is_jump && Input.is_action_just_pressed("Jump"):
		velocity.y = jumpSpeed
		is_jump = true

	# 캐릭터가 바닥과 벽에 있지 않은 경우에만 중력 적용
	if !is_on_floor() && !is_on_wall():
		velocity.y += gravity * delta

	# 캐릭터가 벽에 있을 때
	if !is_on_floor() && is_on_wall():
		if !is_wall:
			velocity.y = 0
		is_wall = true

	# 캐릭터가 바닥에 있다면 플래그 초기화
	if is_on_floor():
		is_jump = false
		is_wall = false

	# 좌, 우로 이동
	if Input.is_action_pressed("Left"):
		if !is_wall:
			velocity.x = -moveSpeed
			sprite.flip_h = true
	if Input.is_action_pressed("Right"):
		if !is_wall:
			velocity.x = moveSpeed
			sprite.flip_h = false

	if !Input.is_action_pressed("Left") && !Input.is_action_pressed("Right") || Input.is_action_pressed("Left") && Input.is_action_pressed("Right"):
		if is_on_floor():
			velocity.x = 0

	# 캐릭터 애니메이션
	if is_on_floor():
		if velocity.x == 0:
			sprite.play("Idle")
		else:
			sprite.play("Run")
	else:
		if is_on_wall():
			sprite.play("Jump_Wall")
		elif velocity.y < 0 && is_jump:
			sprite.play("Jump_Double")
		elif velocity.y < 0:
			sprite.play("Jump")
		else:
			sprite.play("Fall")

	move_and_slide()
