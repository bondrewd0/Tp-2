extends Area3D

var Conquered:bool=false
var enemies:int=0
@export var Station:Node3D=null
var Enemy_list:Array[Enemy_ship]
const ORIGIN_POINT = preload("res://origin_point.tscn")
signal entering_combat
func _ready() -> void:
	for child in get_children():
		if child is Enemy_ship:
			Enemy_list.push_front(child)
			child.destroyed.connect(guard_destroyed)
			var originpoint=ORIGIN_POINT.instantiate()
			add_child(originpoint)
			originpoint.position=child.position
			originpoint.Designated_Ship=child
			child.OriginPoint=originpoint.global_position
			enemies+=1
			
	print(Enemy_list)


func _on_body_entered(body: Node3D) -> void:
	print(body)
	if body is PlayerShip:
		entering_combat.emit()
		for child in Enemy_list:
			child.Target=body
			print("target assigned")
			GlobalStuff.player_in_combat.emit()

func guard_destroyed(child_ref:Enemy_ship):
	enemies-=1
	Enemy_list.erase(child_ref)
	print(Enemy_list)
	if enemies<=0:
		print("coquered")
		monitorable=false
		monitoring=false
		Station.set_friendly_mode()


func _on_body_exited(body: Node3D) -> void:
	if body is PlayerShip:
		GlobalStuff.player_away.emit()
