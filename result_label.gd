extends Label

func _ready() -> void:
	add_to_group("result_label")
	hide()
	set_anchors_and_offsets_preset(Control.PRESET_CENTER)

func show_result(won: bool) -> void:
	if won:
		text = "YOU WIN!"
		add_theme_color_override("font_color", Color.GREEN)
	else:
		text = "YOU LOSE!"
		add_theme_color_override("font_color", Color.RED)

	show()
