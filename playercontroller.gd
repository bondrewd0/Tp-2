# Example for CharacterBody3D arcade movement
extends CharacterBody3D

@export var speed = 5.0
@export var rotation_speed = 2.0
@export var Friction:float=0.1
var input_dir = Vector3.ZERO
var backwards_speed:float=1
var moving:bool=false
func _physics_process(delta):
	# Get input

	if Input.is_action_pressed("forward"):
		input_dir += -transform.basis.z
		backwards_speed=1
		moving=true
	if Input.is_action_pressed("backward"):
		backwards_speed=0.5
		moving=true
		input_dir += transform.basis.z*0.1
	if Input.is_action_pressed("left"):
		rotate_y(rotation_speed * delta)
	if Input.is_action_pressed("right"):
		rotate_y(-rotation_speed * delta)
	if Input.is_action_just_released("forward") or Input.is_action_just_released("backward"):
		moving=false
	if not moving:
		input_dir=Vector3.ZERO
		velocity.x=move_toward(velocity.x,0,Friction)
		velocity.z=move_toward(velocity.z,0,Friction)
	# Move and slide
	else:
		velocity = input_dir.normalized() * speed*backwards_speed
	move_and_slide()
