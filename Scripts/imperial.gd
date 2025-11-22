extends RigidBody3D

var dir:Vector3=Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction:Vector3=Vector3(
			Input.get_action_strength("left")-Input.get_action_strength("right"),
			0.0,
			Input.get_action_strength("forward")-Input.get_action_strength("backward")).normalized()
	var target_velocity=direction*5
