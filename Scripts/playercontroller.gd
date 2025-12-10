
extends CharacterBody3D
class_name PlayerShip
@onready var hit_sound: AudioStreamPlayer3D = $HitSound
@onready var effect_anim: AnimationPlayer = $"../Effect/EffectAnim"

@export var max_speed = 20.0
@export var acceleration = 1.0
@export var yaw_speed = 1.0
@export var input_response: float = 10.0
@export var Inventory:ResContainer
@export var Currrent_Vessel:Vessel=null
@export var HP:int=5
var ded = false
var current_hp:int=0
var forward_speed:float = 0.0

var yaw_input: float = 0.0
var moving = false
var can_control:bool=true
signal hp_changed
func _ready() -> void:
	UpgradesManager.initiate(self)
	current_hp=HP

func get_input(delta):
	if Input.is_action_pressed("forward"):
		forward_speed = lerp(forward_speed, max_speed, acceleration * delta)
		moving = true
	if Input.is_action_pressed("backward"):
		forward_speed = lerp(forward_speed, -1.0, delta)
		moving = true
	else:
		moving = false
	
	yaw_input = lerp(yaw_input,Input.get_action_strength("left") - Input.get_action_strength("right"), 
	input_response * delta)
	#roll_input = lerp(roll_input,Input.get_action_strength("left") - Input.get_action_strength("right"), 
	#input_response * delta)
	#yaw_input = roll_input
	
func _on_hitbox_area_entered(area: Area3D) -> void:
	hit_sound.play()
	current_hp-=1
	hp_changed.emit()
	print("Player hit")
	if current_hp<=0:
		effect_anim.play("FadeOutLose")
		print("dead lol")
		#await effect_anim.animation_finished
		
		#Lose
#func _process(delta: float) -> void:
	#if ded == false:
		
		
func change_level_lose():
	get_tree().change_scene_to_file("res://Scenes/LevelElements/Lose.tscn")
	
func _physics_process(delta: float) -> void:
	if not can_control:
		
		if velocity!=Vector3.ZERO:
			forward_speed=0
			
			velocity.x=move_toward(velocity.x,0,0.5)
			velocity.z=move_toward(velocity.z,0,0.5)
			move_and_slide()
		else:
			
			return
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	#transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	#rotate_y(rotation_speed * delta * yaw_input_right)
	#rotate_y(rotation_speed * delta * yaw_input_left)
	velocity = -transform.basis.z * forward_speed
	move_and_collide(velocity * delta)

func remove_cannons():
	for child in get_children():
		if child is Cannon:
			child.queue_free()

func heal_up():
	current_hp=HP
	hp_changed.emit()
	
