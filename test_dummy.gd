extends RigidBody3D
class_name Enemy_ship
@export var Health:int=5
@export var Target:Node3D=null
@export var Speed: float = 100.0
@export var attack_distance: float = 10.0  # Distance at which to start circling
@export var circle_radius: float = 8.0     # Desired orbit radius
@export var orbit_speed: float = 2.0       # How fast to circle around
var in_range:bool=false
func _physics_process(delta: float) -> void:
	if not Target: return
	
	var target_pos: Vector3 = Target.global_position
	var to_target = target_pos - global_position
	var distance = to_target.length()
	if not in_range:
		# Approach behavior - move directly toward target
		var direction = to_target.normalized()
		apply_central_force(direction * Speed)
	else:
		# Circling behavior - like a pirate ship
		var direction_to_target = to_target.normalized()
		# Create a tangent vector (perpendicular to the direction to target)
		# This makes the enemy move sideways relative to the target
		var tangent = Vector3(direction_to_target.z, 0, -direction_to_target.x).normalized()     
		# Combine tangent movement with slight inward/outward correction
		var radius_error = distance - circle_radius
		var corrective_force = direction_to_target * radius_error * 0.5    
		# Apply the circling force
		apply_central_force((tangent * orbit_speed + corrective_force) * Speed)
	if linear_velocity.length() > 0.1:  # Only rotate if moving
		var look_direction = linear_velocity.normalized()
		var target_transform = global_transform.looking_at(global_position + look_direction, Vector3.UP)
		global_transform = global_transform.interpolate_with(target_transform, 5.0 * delta)
func _on_area_3d_body_entered(body: Node3D) -> void:
	print("dentro")
	in_range=true


func _on_fire_zone_body_exited(body: Node3D) -> void:
	print("fuera")
	in_range=false

func _on_hitbox_area_entered(area: Area3D) -> void:
	var check_bullet=area.get_parent()
	if check_bullet is Bullet:
		print("Hit")
		take_damage()

func take_damage():
	Health-=1
	print(Health)
	if Health<=0:
		queue_free()
