extends Node3D

@export var TurretBase:MeshInstance3D=null
@export var TurretCanon:MeshInstance3D=null
@export var BulletSpawnPos:Marker3D=null
@export var Target:PhysicsBody3D=null
@export var Vel_Cannon:float=0.5
@export var Vel_Torre:float=0.5
@onready var cooldown: Timer = $Cooldown
@export var Bullet_path:PackedScene
var target_locked:bool=false
var can_shoot:bool=true
const BULLET = preload("res://bullet.tscn")
func shoot():
	#print("fire!!")
	var bullet_inst=Bullet_path.instantiate()
	#print(bullet_inst)
	get_parent().add_sibling(bullet_inst)
	bullet_inst.transform=BulletSpawnPos.global_transform
	bullet_inst.linear_velocity=BulletSpawnPos.global_transform.basis.z*-1*20
	can_shoot=false



func _process(delta: float) -> void:
	if Target:
		ajustar_torreta(delta)
	else:
		return_to_idle()

func angulo_obj(pos_base:Vector3,pos_obj:Vector3,dir:Vector3):
	var direction=pos_base.direction_to(pos_obj)
	dir=dir.normalized()
	direction=direction.normalized()
	return acos(dir.dot(direction))

func conseguir_proyeccion(pos:Vector3,normal:Vector3):
	normal=normal.normalized()
	var proyeccion:Vector3=(pos.dot(normal)/normal.dot(normal))*normal
	return pos-proyeccion

func return_to_idle():
	TurretBase.rotation.y=move_toward(TurretBase.rotation.y,0,0.002)

func ajustar_torreta(delta:float):
	var rot_obj:Vector3=conseguir_proyeccion(Target.global_position-TurretBase.global_position,TurretBase.global_basis.y)
	rot_obj=rot_obj+TurretBase.global_position
	var angulo_y:float=angulo_obj(TurretBase.global_position,rot_obj,TurretBase.global_basis.z)
	var aux1:float=sign(TurretBase.to_local(Target.global_position).x)
	var final_y:float=aux1*min(Vel_Torre*delta,angulo_y)
	TurretBase.rotate_y(final_y)
	TurretBase.rotation.y=clampf(TurretBase.rotation.y,-0.3,0.3)


func _on_radar_body_entered(body: Node3D) -> void:
	#print("target locked", body)
	
	if body is PlayerShip or body is Enemy_ship:
		if Target:
			if get_distance_to_object(body)<get_distance_to_object(Target):
				Target=null
				Target=body
		else:
			Target=body

func get_distance_to_object(object:Node3D):
	var target_pos: Vector3 = object.global_position
	var to_target = target_pos - global_position
	var distance = to_target.length()
	print(distance)
	return distance

func _on_lock_on_body_entered(body: Node3D) -> void:
	#print("opne fire!")
	target_locked=true
	if can_shoot:
		shoot()
	if cooldown.is_stopped():
		cooldown.start()


func _on_cooldown_timeout() -> void:
	can_shoot=true
	if not target_locked:
		#print("no target")
		return
	shoot()
	cooldown.start()


func _on_lock_on_body_exited(body: Node3D) -> void:
	target_locked=false
	#print("target not in range")

func _on_radar_body_exited(body: Node3D) -> void:
	#print("target lost")
	Target=null
