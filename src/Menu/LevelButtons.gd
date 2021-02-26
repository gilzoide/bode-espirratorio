extends Panel

export(float) var collapse_duration: float = 0.5
export(float) var first_collapse_duration: float = 1.0
onready var tween: Tween = $Tween
var is_animating: bool = false
onready var initial_position = rect_position

func _ready():
	toggle_collapsed(first_collapse_duration)
	$Basketball.grab_focus()

func toggle_collapsed(duration: float = collapse_duration):
	if not is_animating:
		var target: Vector2 = initial_position
		if rect_position.is_equal_approx(initial_position):
			target.x = 0
		tween.interpolate_property(
			self, "rect_position",
			rect_position, target,
			duration,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
		)
		tween.start()
