extends AudioStreamPlayer

func _ready() -> void:
	play()
	finished.connect(_on_music_finished)

func _on_music_finished() -> void:
	play()
