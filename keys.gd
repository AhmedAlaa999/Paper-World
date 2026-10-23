extends Area2D

var collected: bool = false

func _on_body_entered(body: Node2D) -> void:
	if collected or GameManager.game_over:
		return
	if not body.is_in_group("player"):
		return

	collected = true
	GameManager.collect_key()
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	await $AudioStreamPlayer2D.finished
	queue_free()
