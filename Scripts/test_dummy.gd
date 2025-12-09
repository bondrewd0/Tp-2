extends RigidBody3D
class_name Enemy_ship
@export var MaxHealth:int=5
@export var Target:Node3D=null
@export var Speed: float = 100.0
@export var circle_radius: float = 8.0     # Desired orbit radius
@export var orbit_speed: float = 2.0       # How fast to circle around
@export var OriginPoint:Vector3=Vector3.ZERO
@onready var hit_sound: AudioStreamPlayer3D = $HitSound
@onready var enemy_death: AudioStreamPlayer3D = $EnemyDeath
@onready var enemy_t_1: Enemy_ship = $"."
@onready var collision_shape_3d: CollisionShape3D = $Hitbox/CollisionShape3D
@onready var fire_zone: Area3D = $FireZone
@onready var hitbox: Area3D = $Hitbox
@onready var enemy_death_sound: AudioStreamPlayer3D = $EnemyDeath
@export var Drops:Array[Stack]=[]
@export var drop_multiplier:float=1


var random_orbi_dir:int=1
var in_range:bool=false
var current_health:int=0
signal destroyed(self_reference:Enemy_ship)
func _ready() -> void:
	current_health=MaxHealth
	GlobalStuff.player_away.connect(stop_chase)
	fire_zone.body_entered.connect(_on_area_3d_body_entered)
	fire_zone.body_exited.connect(_on_fire_zone_body_exited)
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	enemy_death_sound.finished.connect(_on_enemy_death_finished)
	print(Drops)
	for object in Drops:
		var drop_amount=randi_range(5,10)
		drop_amount*=drop_multiplier
		print("amo", drop_amount)
		object.add_amount(drop_amount)
		print(object.amount)

func _physics_process(delta: float) -> void:
	if not Target: 
		if OriginPoint!=Vector3.ZERO:
			return_to_origin()
		return
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
		apply_central_force((tangent * (random_orbi_dir*orbit_speed) + corrective_force) * Speed)
	if linear_velocity.length() > 0.1:  # Only rotate if moving
		var look_direction = linear_velocity.normalized()
		var target_transform = global_transform.looking_at(global_position + look_direction, Vector3.UP)
		global_transform = global_transform.interpolate_with(target_transform, 5.0 * delta)

func _on_area_3d_body_entered(body: Node3D) -> void:
	set_radnom_dir()
	print(random_orbi_dir)
	in_range=true

func set_radnom_dir():
	random_orbi_dir=randi_range(-1,1)
	if random_orbi_dir==0:
		set_radnom_dir()

func _on_fire_zone_body_exited(body: Node3D) -> void:
	in_range=false

func _on_hitbox_area_entered(area: Area3D) -> void:
	var check_bullet=area.get_parent()
	if check_bullet is Bullet:
		take_damage()

func take_damage():
	hit_sound.play()
	print("hitted")
	current_health-=1
	print(current_health)
	
	
	if current_health<=0:
		GlobalStuff.sendloot.emit(Drops)
		enemy_death.play()
		enemy_t_1.hide()
		 
		collision_shape_3d.set_deferred("disabled",true)
		set_physics_process(false)
		destroyed.emit(self)
		
func _on_enemy_death_finished() -> void:
	queue_free()
	
func stop_chase():
	Target=null
	in_range=false

func return_to_origin():
	var to_origin = OriginPoint - global_position
	# Approach behavior - move directly toward target
	var direction = to_origin.normalized()
	var distance = to_origin.length()
	if linear_velocity.length() > 0.1:  # Only rotate if moving
		var look_direction = linear_velocity.normalized()
		var target_transform = global_transform.looking_at(global_position + look_direction, Vector3.UP)
		global_transform = global_transform.interpolate_with(target_transform, 5.0 * 0.05)
	if distance>3:
		apply_central_force(direction * Speed)

func Heal_up():
	current_health=MaxHealth
