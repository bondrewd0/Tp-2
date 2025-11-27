# Example for CharacterBody3D arcade movement
extends CharacterBody3D
class_name PlayerShip

@export var max_speed = 20.0
@export var acceleration = 1.0
@export var yaw_speed = 1.0
@export var input_response: float = 10.0
var forward_speed = 0.0

var yaw_input: float = 0.0
var moving = false


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
	print("Player hit")
	
func _physics_process(delta: float) -> void:
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	#transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	#rotate_y(rotation_speed * delta * yaw_input_right)
	#rotate_y(rotation_speed * delta * yaw_input_left)
	velocity = -transform.basis.z * forward_speed
	move_and_collide(velocity * delta)
	print(velocity)
	#if Input.is_action_just_released("forward"):
		#print("ay")
		#velocity=Vector3.ZERO
		#velocity.z=move_toward(velocity.z,0,friction)
	#else:
		#
		#print("me estoy moviendo")

#if Input.is_action_just_pressed("left"):
		#yaw_input_left = lerp(yaw_input, 1.0, input_response * delta)
		#print("left pressed")
	#if Input.is_action_just_pressed("right"):
		#yaw_input_right = lerp(yaw_input, 1.0, input_response * delta) * -1
		#print("right pressed")
	#yaw_input_left = lerp(yaw_input, float(Input.is_action_just_pressed("left")), input_response * delta)
	#yaw_input_right = (lerp(yaw_input, float(Input.is_action_just_pressed("right")), input_response * delta)* -1)
	#roll_input = Input.is_action_just_pressed("left") - Input.is_action_just_pressed("left")
	#yaw_input = Input.is_action_just_pressed("left")
#Yaw y roll


#@export var speed = 5.0
#@export var rotation_speed = 5.0
#@export var Rotating_friction:float=0.5
#@export var Friction:float=0.1
#var input_dir = Vector3.ZERO
#var backwards_speed:float=1
#var moving:bool=false
#var rotating:bool=false
#var can_control:bool=true
#func _physics_process(delta):
	## Get input
	#if  Input.is_action_just_pressed("test"):
		#can_control=!can_control
		#print(can_control)
	#if not can_control:
		#if velocity!=Vector3.ZERO:
			#velocity.x=move_toward(velocity.x,0,Friction)
			#velocity.z=move_toward(velocity.z,0,Friction)
			#move_and_slide()
		#else:
			#return
	#if Input.is_action_pressed("forward"):
		#input_dir += -transform.basis.z
		#backwards_speed=1
		#moving=true
	#if Input.is_action_pressed("backward"):
		#backwards_speed=0.5
		#moving=true
		#input_dir += transform.basis.z*0.1
	#if Input.is_action_pressed("left"):
		#rotate_y(rotation_speed * delta)
		#rotating=true
	#if Input.is_action_pressed("right"):
		#rotate_y(-rotation_speed * delta)
		#rotating=true
	#if Input.is_action_just_released("forward") or Input.is_action_just_released("backward"):
		#moving=false
	#if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		#rotating=false
	#if not moving:
		#input_dir=Vector3.ZERO
		#velocity.x=move_toward(velocity.x,0,Friction)
		#velocity.z=move_toward(velocity.z,0,Friction)
	## Move and slide
	#else:
		#if not rotating:
			#velocity = input_dir.normalized() * speed*backwards_speed
		#else:
			#velocity = input_dir.normalized() * speed*backwards_speed*Rotating_friction
	#move_and_slide()
#
#
