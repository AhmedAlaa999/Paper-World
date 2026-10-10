
extends Sprite2D

@export var show_time: float = 1.0
@export var hide_time: float = 1.0

func _ready() -> void:
	hide()
	start_alert_loop()

func start_alert_loop() -> void:
	while true:
		await get_tree().create_timer(hide_time).timeout

		show()

		await get_tree().create_timer(show_time).timeout

		hide()
