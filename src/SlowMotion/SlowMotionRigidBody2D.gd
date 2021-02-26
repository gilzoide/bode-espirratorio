extends RigidBody2D

export(Resource) var slow_motion_group: Resource = preload("res://SlowMotion/DefaultSlowMotionGroup.tres")
export(bool) var restore_momentum: bool = true
export(bool) var should_reset_transform: bool = false
onready var initial_transform = global_transform
onready var initial_linear_velocity = linear_velocity
onready var initial_angular_velocity = angular_velocity
onready var previous_linear_velocity = initial_linear_velocity
onready var previous_angular_velocity = initial_angular_velocity

func _enter_tree() -> void:
	var _err = slow_motion_group.connect("slow_motion_started", self, "_on_slow_motion_started")
	_err = slow_motion_group.connect("slow_motion_stopped", self, "_on_slow_motion_ended")

func _exit_tree() -> void:
	slow_motion_group.disconnect("slow_motion_started", self, "_on_slow_motion_started")
	slow_motion_group.disconnect("slow_motion_stopped", self, "_on_slow_motion_ended")

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if should_reset_transform:
		should_reset_transform = false
		state.transform = initial_transform
		state.linear_velocity = initial_linear_velocity
		state.angular_velocity = initial_angular_velocity
	elif slow_motion_group.is_in_slow_motion:
		state.linear_velocity = previous_linear_velocity * slow_motion_group.slow_motion_factor
		state.angular_velocity = previous_angular_velocity * slow_motion_group.slow_motion_factor

func cache_momentum() -> void:
	previous_linear_velocity = linear_velocity
	previous_angular_velocity = angular_velocity

func _on_slow_motion_started() -> void:
	cache_momentum()

func _on_slow_motion_ended() -> void:
	if restore_momentum:
		linear_velocity = previous_linear_velocity
		angular_velocity = previous_angular_velocity
