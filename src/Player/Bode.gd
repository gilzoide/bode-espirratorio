extends RigidBody2D

func _ready() -> void:
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("espirro"):
		start_sneezing()


func start_sneezing() -> void:
	pass
