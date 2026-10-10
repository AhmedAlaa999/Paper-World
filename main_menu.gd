
extends Control

@onready var play_button: Button = $CenterContainer/MenuLayout/PlayButton
@onready var settings_button: Button = $CenterContainer/MenuLayout/SettingsButton
@onready var quit_button: Button = $CenterContainer/MenuLayout/QuitButton
@onready var button_sound: AudioStreamPlayer = $ButtonSound

var is_transitioning := false

const GAME_SCENE := "res://Scenes/Game.tscn"
const SETTINGS_SCENE := "res://Scenes/Settings.tscn"

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _on_play_pressed() -> void:
	await transition_to_scene(GAME_SCENE)


func _on_settings_pressed() -> void:
	await transition_to_scene(SETTINGS_SCENE)


func _on_quit_pressed() -> void:
	if button_sound.playing:
		await button_sound.finished

	get_tree().quit()


func transition_to_scene(scene_path: String) -> void:
	if is_transitioning:
		return

	is_transitioning = true

	button_sound.play()

	var overlay := ColorRect.new()
	overlay.color = Color("#302840")
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)

	add_child(overlay)
	move_child(overlay, get_child_count() - 1)

	overlay.modulate.a = 0.0

	var tween := create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(
		overlay,
		"modulate:a",
		1.0,
		0.65
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	await tween.finished

	var error := get_tree().change_scene_to_file(scene_path)

	if error != OK:
		push_error("Failed to load scene: " + scene_path)
		overlay.queue_free()
		is_transitioning = false
		return
