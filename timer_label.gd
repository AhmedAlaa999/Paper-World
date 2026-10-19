extends Label

func _ready() -> void:
	update_timer()

func _process(_delta: float) -> void:
	update_timer()

func update_timer() -> void:
	var seconds := int(ceil(GameManager.time_left))
	text = "Time: %02d:%02d" % [
		seconds / 60,
		seconds % 60
	]

	if seconds <= 10:
		add_theme_color_override("font_color", Color.RED)
	else:
		add_theme_color_override("font_color", Color.WHITE)
