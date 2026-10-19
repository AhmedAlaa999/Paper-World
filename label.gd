extends Label

@export var message: String = "Collect Coins"
@export var display_time: float = 2.5
@export var fade_duration: float = 0.6

func _ready() -> void:
	text = message
	add_theme_font_size_override("font_size", 25)
	if get_theme_font("font") is FontFile:
		var font_file := get_theme_font("font") as FontFile
		font_file.antialiasing = TextServer.FONT_ANTIALIASING_LCD
	modulate.a = 0.0

	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, fade_duration)
	tween.tween_interval(display_time)
	tween.tween_property(self, "modulate:a", 0.0, fade_duration)

	await tween.finished
	queue_free()
