extends CanvasItem

export(float) var duration : float = 1
export(float) var speed : float = 1
export(bool) var looping : bool = true
var time : float = 0
var value : float = 0

func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	time += delta * speed
	if time > duration or time < 0:
		if not looping:
			set_process(false)
		speed = -speed
		time = clamp(time, 0, duration)
	set_angle(value)
	value = time / duration

func set_angle(angle: float) -> void:
	material.set_shader_param("textured_angle", angle)
