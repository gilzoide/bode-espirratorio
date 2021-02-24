extends Node

signal scored()

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("basketball"):
		emit_signal("scored")
