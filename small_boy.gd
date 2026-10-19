extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -200.0
const GRAVITY = 980.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		animated_sprite.play("Jump")
	elif direction != 0:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Ideal")

	move_and_slide()
