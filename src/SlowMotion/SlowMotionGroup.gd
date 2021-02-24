extends Resource

signal slow_motion_started()
signal slow_motion_stopped()

export(bool) var is_in_slow_motion: bool = false setget set_slow_motion, get_slow_motion
export(float) var slow_motion_factor: float = 0.1

var _is_in_slow_motion: bool = false

func _init(_slow_motion_factor: float = 0.1) -> void:
	slow_motion_factor = _slow_motion_factor

func set_slow_motion(value: bool) -> void:
	_is_in_slow_motion = value
	if _is_in_slow_motion:
		emit_signal("slow_motion_started")
	else:
		emit_signal("slow_motion_stopped")

func get_slow_motion() -> bool:
	return _is_in_slow_motion
