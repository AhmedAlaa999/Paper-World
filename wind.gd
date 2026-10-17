extends Sprite2D

@export var min_wait: float = 2.0
@export var max_wait: float = 6.0
@export var wind_speed: float = 1.6
@export var travel_distance: float = 500.0
@export var fade_time: float = 0.25

@export var sound_fade_in: float = 0.5
@export var sound_fade_out: float = 1.0
@export var sound_volume_db: float = -15.0

@onready var wind_audio: AudioStreamPlayer = $wind_audio

var start_position: Vector2


func _ready() -> void:
	start_position = position
	modulate.a = 0.0
	visible = false

	wind_audio.volume_db = -40.0

	randomize()
	play_wind_loop()


func play_wind_loop() -> void:
	while true:
		await get_tree().create_timer(
			randf_range(min_wait, max_wait)
		).timeout

		visible = true
		position = start_position + Vector2(-travel_distance, 0)
		modulate.a = 0.0

		wind_audio.volume_db = -40.0

		if wind_audio.stream:
			wind_audio.play()

		var audio_in = create_tween()
		audio_in.tween_property(
			wind_audio,
			"volume_db",
			sound_volume_db,
			sound_fade_in
		)

		var tween = create_tween()

		tween.tween_property(
			self,
			"modulate:a",
			0.8,
			fade_time
		)

		tween.parallel().tween_property(
			self,
			"position",
			start_position + Vector2(travel_distance, 0),
			wind_speed
		).set_trans(Tween.TRANS_LINEAR)

		tween.tween_property(
			self,
			"modulate:a",
			0.0,
			fade_time
		)

		await tween.finished

		var audio_out = create_tween()
		audio_out.tween_property(
			wind_audio,
			"volume_db",
			-40.0,
			sound_fade_out
		)

		await audio_out.finished

		wind_audio.stop()
		wind_audio.volume_db = -40.0
		visible = false
