extends Camera2D

@export var player: Node2D
@export var starting_speed: float = 100.0
@export var max_speed: float = 400.0
@export var acceleration: float = 5.0

var camera_speed: float = 100.0
var has_lost: bool = false
var game_started: bool = false


func _ready() -> void:
	enabled = true
	position_smoothing_enabled = false
	camera_speed = starting_speed

	if player == null:
		player = get_parent().get_node_or_null("SmallBoy")

	start_game()

func start_game() -> void:
	var ready_label: Label = get_tree().current_scene.get_node_or_null(
        "CanvasLayer/ReadyLabel"
	)

	get_tree().paused = true

	if ready_label:
		ready_label.show()
		ready_label.text = "READY!"

	await get_tree().create_timer(3.0, true, false, true).timeout

	if not is_instance_valid(self):
		return

	if ready_label and is_instance_valid(ready_label):
		ready_label.text = "GO!"

	get_tree().paused = false
	game_started = true

	if ready_label and is_instance_valid(ready_label):
		await get_tree().create_timer(0.5).timeout

		if is_instance_valid(ready_label):
			ready_label.hide()


func _process(delta: float) -> void:
	if not game_started or has_lost or GameManager.game_over:
		return

	camera_speed = min(
		camera_speed + acceleration * delta,
		max_speed
	)

	global_position.x += camera_speed * delta

	if player == null:
		return

	var half_width: float = get_viewport_rect().size.x * 0.5 / zoom.x
	var left_edge: float = get_screen_center_position().x - half_width

	if player.global_position.x < left_edge:
		lose_game()

func lose_game() -> void:
	if has_lost:
		return

	has_lost = true
	GameManager.game_over = true

	get_tree().call_group("result_label", "show_result", false)
	get_tree().paused = true
