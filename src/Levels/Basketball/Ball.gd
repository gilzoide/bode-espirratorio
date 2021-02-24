extends "res://SlowMotion/SlowMotionRigidBody2D.gd"

export(float) var bounce_factor: float = 500

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	._integrate_forces(state)
	for i in range(state.get_contact_count()):
		if state.get_contact_collider_object(i) is RigidBody2D:
			var normal = state.get_contact_local_normal(i).normalized()
			apply_central_impulse(normal * bounce_factor)
