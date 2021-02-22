extends CanvasItem

export(float) var duration : float = 1
export(float) var speed : float = 1
export(bool) var looping : bool = true
var time : float = 0
var value : float = 0

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	time += delta * speed
	if time > duration or time < 0:
		if not looping:
			set_process(false)
		time = clamp(time, 0, duration)
	value = time / duration
