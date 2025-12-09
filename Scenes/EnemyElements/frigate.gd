extends Enemy_ship
class_name Heavy_Enemy

@export var pass_distance: float = 15.0  # How far to the side it passes
@export var turning_distance: float = 25.0  # How far past target before turning
@export var turn_sharpness: float = 3.0  # How tight the turns are

var attack_phase: int = 0  # 0 = approach, 1 = passing, 2 = looping back
var pass_direction: Vector3 = Vector3.ZERO
var turn_point: Vector3 = Vector3.ZERO

func _ready() -> void:
	super._ready()
	# Pick a random side to pass on
	var angle = randf() * TAU
	pass_direction = Vector3(cos(angle), 0, sin(angle))

func _physics_process(delta: float) -> void:
	if not Target:
		if OriginPoint != Vector3.ZERO:
			return_to_origin()
		return
	
	var target_pos: Vector3 = Target.global_position
	var to_target = target_pos - global_position
	var distance = to_target.length()
	
	match attack_phase:
		0:  # Approach phase - head toward a point beside the target
			var offset_target = target_pos + pass_direction * pass_distance
			var to_offset = offset_target - global_position
			var direction = to_offset.normalized()
			apply_central_force(direction * Speed)
			
			# Switch to passing phase when close enough
			if to_offset.length() < pass_distance * 0.5:
				attack_phase = 1
				# Set turn point ahead of target
				turn_point = target_pos + pass_direction.cross(Vector3.UP).normalized() * turning_distance
		
		1:  # Passing phase - fly past the target
			var to_turn_point = turn_point - global_position
			var direction = to_turn_point.normalized()
			apply_central_force(direction * Speed)
			
			# Start turning when we pass the turn point
			if to_turn_point.length() < 5.0:
				attack_phase = 2
		
		2:  # Looping back phase - curve back toward target
			var direction_to_target = to_target.normalized()
			apply_central_force(direction_to_target * Speed * 0.8)
			
			# Reset when close enough to start another pass
			if distance < pass_distance * 1.5:
				attack_phase = 0
				# Pick new random pass direction
				var angle = randf() * TAU
				pass_direction = Vector3(cos(angle), 0, sin(angle))
	
	# Rotate to face movement direction (Y-axis only, no tilt)
	if linear_velocity.length() > 0.1:
		var look_direction = linear_velocity.normalized()
		# Flatten the look direction to XZ plane
		look_direction.y = 0
		look_direction = look_direction.normalized()
		
		var look_pos = global_position + look_direction
		look_pos.y = global_position.y  # Keep same height
		var target_transform = global_transform.looking_at(look_pos, Vector3.UP)
		global_transform = global_transform.interpolate_with(target_transform, turn_sharpness * delta)
