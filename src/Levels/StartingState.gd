extends Node

func reset() -> void:
	for i in range(get_child_count()):
		var body = get_child(i)
		body.should_reset_transform = true
