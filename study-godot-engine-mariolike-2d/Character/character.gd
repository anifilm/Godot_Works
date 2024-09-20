extends CharacterBody2D


@export var gravity = 980
@export var jumpSpeed = -400
@export var moveSpeed = 200
@onready var sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
    # 캐릭터가 바닥에 있지 않은 경우에만 중력 적용
    if !is_on_floor():
        velocity.y += gravity * delta

    # 캐릭터가 바닥에 있고 점프 버튼을 눌렸을 때
    if is_on_floor() && Input.is_action_just_pressed("Jump"):
        velocity.y = jumpSpeed

    # 좌, 우로 이동
    if Input.is_action_pressed("Left"):
        velocity.x = -moveSpeed
        sprite.flip_h = true
    if Input.is_action_pressed("Right"):
        velocity.x = moveSpeed
        sprite.flip_h = false

    if !Input.is_action_pressed("Left") && !Input.is_action_pressed("Right") || Input.is_action_pressed("Left") && Input.is_action_pressed("Right"):
        velocity.x = 0

    # 캐릭터 애니메이션
    if !is_on_floor():
        if velocity.y < 0:
            sprite.play("Jump")
        else:
            sprite.play("Fall")
    else:
        if velocity.x == 0:
            sprite.play("Idle")
        else:
            sprite.play("Run")



    move_and_slide()
