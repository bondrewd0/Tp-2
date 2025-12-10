extends MeshInstance3D
class_name Vessel
@export var Cannon_mounts:Array[Marker3D]
@export var Current_Cannons:int=2
@export var Max_Cannons:int=2
@export var Max_Helath:int=5
@export var Max_Speed_Value:int=20
@export var Current_Speed:float=0
@export var Current_Health:int=0
func _ready():
	if Max_Cannons==0 or Max_Cannons%2!=0:
		printerr("invalid cannon number")
		queue_free()
	
func add_mounts_to_list():
	print("cannons ", Current_Cannons)
	var added:int=0
	for child in get_children():
		if added<Current_Cannons:
			if child is Marker3D:
				Cannon_mounts.push_back(child)
				added+=1


func get_mounts():
	return Cannon_mounts

func get_firerate():
	for child in get_children():
		if child is Cannon:
			print("cooldown ", child.cooldown.wait_time)
			return child.cooldown.wait_time
	return 2

func set_cannon_attack_rate(rate:float):
	print("reciebed ", rate)
	for child in get_children():
		if child is Cannon:
			print("detected cannon")
			child.change_cool_down(rate)
