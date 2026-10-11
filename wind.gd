
extends Sprite2D

@export var min_wait: float = 2.0
@export var max_wait: float = 6.0
@export var wind_speed: float = 1.6
@export var travel_distance: float = 500.0
@export var fade_time: float = 0.25

var start_position: Vector2


func _ready() -> void:
	start_position = position
	modulate.a = 0.0
	visible = false

	randomize()
	play_wind_loop()


func play_wind_loop() -> void:
	while true:
		# Wait before the next wind gust
		await get_tree().create_timer(
			randf_range(min_wait, max_wait)
		).timeout

		# Start from the LEFT (-X)
		visible = true
		position = start_position + Vector2(-travel_distance, 0)
		modulate.a = 0.0

		# Create the animation
		var tween = create_tween()

		# Fade in while moving
		tween.tween_property(
			self,
			"modulate:a",
			0.8,
			fade_time
		)

		# Move from LEFT to RIGHT
		tween.parallel().tween_property(
			self,
			"position",
			start_position + Vector2(travel_distance, 0),
			wind_speed
		).set_trans(Tween.TRANS_LINEAR)

		# Fade out at the end
		tween.tween_property(
			self,
			"modulate:a",
			0.0,
			fade_time
		)

		# Wait until the animation finishes
		await tween.finished

		# Hide until the next gust
		visible = false
