extends MeshInstance3D
class_name Vessel
@export var Cannon_mounts:Array[Marker3D]
@export var Max_Cannons:int=2

func _ready():
	if Max_Cannons==0 or Max_Cannons%2!=0:
		printerr("invalid cannon number")
		queue_free()
	
func add_mounts_to_list():
	var added:int=0
	for child in get_children():
		if added<UpgradesManager.current_cannons:
			if child is Marker3D:
				Cannon_mounts.push_back(child)
				added+=1


func get_mounts():
	return Cannon_mounts
