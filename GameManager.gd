extends Node
# GameGlobalManager for all systems

var keys_collected: int = 0
var total_keys: int = 13
var time_left: float = 60.0
var game_over: bool = false

func _process(delta: float) -> void:
	if game_over:
		return

	time_left -= delta * 2.0

	if time_left <= 0:
		time_left = 0
		game_over = true
		get_tree().call_group("result_label", "show_result", false)

func collect_key() -> void:
	if game_over:
		return

	keys_collected += 1
	get_tree().call_group("key_counter", "update_counter")

	if keys_collected >= total_keys:
		game_over = true
		get_tree().call_group("result_label", "show_result", true)

func reset_game() -> void:
	keys_collected = 0
	time_left = 60.0
	game_over = false

	get_tree().call_group("key_counter", "update_counter")
