extends RigidBody2D

export(Vector2) var sneeze_impulse : Vector2 = Vector2.UP
export(float) var sneeze_torque : float = 30
export(float) var sneezing_speed_factor : float = 0.1

onready var intensity_gauge = $Visuals/IntensityGauge
onready var sprite = $Visuals/Sprite
onready var animation_player = $AnimationPlayer
var is_sneezing : bool = false

func _ready() -> void:
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("espirro"):
		start_sneezing()
		animation_player.play("ComecaEspirrar")
	elif event.is_action_released("espirro"):
		animation_player.play("Espirro")

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if is_sneezing:
		state.angular_velocity *= sneezing_speed_factor
		state.linear_velocity *= sneezing_speed_factor

func start_sneezing() -> void:
	is_sneezing = true

func stop_sneezing() -> void:
	is_sneezing = false

func sneeze() -> void:
	stop_sneezing()
	apply_torque_impulse(sneeze_torque * intensity_gauge.angle)
	apply_central_impulse(sneeze_impulse.rotated(rotation) * intensity_gauge.angle)
