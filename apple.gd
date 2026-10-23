extends Area2D

@export var speed_increase: float = 20.0

var collected: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if collected or body.name != "SmallBoy":
		return

	collected = true
	body.SPEED += speed_increase

	queue_free()
