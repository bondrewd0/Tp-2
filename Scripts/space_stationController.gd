extends Node3D
@export var Friend_mesh:MeshInstance3D=null

func set_friendly_mode():
	$EnemyMode.hide()
	$SafeMode.show()
