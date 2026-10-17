
extends Node2D

@export var normal_speed: float = 45.0
@export var dart_speed: float = 100.0
@export var wander_radius: float = 100.0
@export var min_wait: float = 0.4
@export var max_wait: float = 1.5

var home_position: Vector2
var target_position: Vector2
var velocity: Vector2 = Vector2.ZERO

var wait_time: float = 0.0
var darting: bool = false
var dart_timer: float = 0.0

func _ready() -> void:
	randomize()
	home_position = global_position
	choose_new_target()

func _process(delta: float) -> void:
	wait_time -= delta
	dart_timer -= delta

	if dart_timer <= 0.0:
		darting = randf() < 0.25
		dart_timer = randf_range(1.0, 3.0)

	if wait_time <= 0.0:
		choose_new_target()

	var direction = global_position.direction_to(target_position)
	var distance = global_position.distance_to(target_position)

	var speed = dart_speed if darting else normal_speed

	if distance > 3.0:
		velocity = velocity.lerp(
			direction * speed,
			min(delta * 2.5, 1.0)
		)
	else:
		velocity = velocity.lerp(Vector2.ZERO, min(delta * 3.0, 1.0))

	var buzz = Vector2(
		sin(Time.get_ticks_msec() * 0.012),
		cos(Time.get_ticks_msec() * 0.017)
	) * 8.0

	global_position += (velocity + buzz) * delta

func choose_new_target() -> void:
	target_position = home_position + Vector2(
		randf_range(-wander_radius, wander_radius),
		randf_range(-wander_radius, wander_radius)
	)

	wait_time = randf_range(min_wait, max_wait)
