extends RigidBody2D

export(float) var sneeze_impulse : float = 100
#export(float) var sneeze_torque : float = 30
export(float) var sneezing_speed_factor : float = 0.1

onready var sneeze_point = $SneezePoint
onready var sneeze_direction = $SneezeDirection
onready var intensity_gauge = $IntensityGauge
onready var animation_player = $AnimationPlayer
var is_sneezing : bool = false
var sneeze_value : float = 0

func _ready() -> void:
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("espirro"):
		start_sneezing()
		animation_player.play("ComecaEspirrar")
		print("ESPIRRA")
	elif event.is_action_released("espirro"):
		sneeze_value = intensity_gauge.angle
		animation_player.seek(0, true)
		animation_player.play("Espirro")

var previous_angular_velocity
var previous_linear_velocity
func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	if is_sneezing:
		angular_velocity = previous_angular_velocity * sneezing_speed_factor
		linear_velocity = previous_linear_velocity * sneezing_speed_factor

func start_sneezing() -> void:
	previous_angular_velocity = angular_velocity
	previous_linear_velocity = linear_velocity
	is_sneezing = true
#	sleeping = true

func stop_sneezing() -> void:
	is_sneezing = false
#	angular_velocity = previous_angular_velocity
#	linear_velocity = previous_linear_velocity

func sneeze() -> void:
	stop_sneezing()
	sleeping = true
	var impulse = sneeze_value * (sneeze_direction.position - sneeze_point.position).normalized() * sneeze_impulse
	apply_impulse(transform.basis_xform(sneeze_point.position), transform.basis_xform(impulse))
