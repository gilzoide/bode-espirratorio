extends "res://SlowMotion/SlowMotionRigidBody2D.gd"

export(float) var sneeze_impulse : float = 100

onready var sneeze_point = $SneezePoint
onready var sneeze_direction = $SneezeDirection
onready var intensity_gauge = $IntensityGauge
onready var animation_player = $AnimationPlayer
var sneeze_value : float = 0

func _ready() -> void:
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("espirro") or \
			event is InputEventScreenTouch and event.is_pressed() and not event.is_echo():
		start_sneezing()
		animation_player.play("ComecaEspirrar")
	elif event.is_action_released("espirro") or \
			event is InputEventScreenTouch and not event.is_pressed() and not event.is_echo():
		sneeze_value = intensity_gauge.angle
		animation_player.seek(0, true)
		animation_player.play("Espirro")
		sneeze()

func start_sneezing() -> void:
	slow_motion_group.set_slow_motion(true)

func stop_sneezing() -> void:
	slow_motion_group.set_slow_motion(false)

func sneeze() -> void:
	stop_sneezing()
	sleeping = true
	var impulse = sneeze_value * (sneeze_direction.position - sneeze_point.position).normalized() * sneeze_impulse
	apply_impulse(transform.basis_xform(sneeze_point.position), transform.basis_xform(impulse))
