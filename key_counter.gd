extends Label
#the counter system for keys
func _ready() -> void:
	add_to_group("key_counter")
	update_counter()

func update_counter() -> void:
	text = "Keys: %d / 1" % GameManager.keys_collected
