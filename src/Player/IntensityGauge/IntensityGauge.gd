extends CanvasItem

export(float, 0, 1) var angle : float = 0 setget set_angle, get_angle
var _angle: float = 0

func set_angle(value: float) -> void:
	_angle = value
	material.set_shader_param("textured_angle", value)

func get_angle() -> float:
	return _angle
