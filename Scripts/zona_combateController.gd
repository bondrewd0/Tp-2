extends Area3D
class_name CombatZone
var Conquered:bool=false
var enemies:int=0
@export var Station:Node3D=null
var Enemy_list:Array[Enemy_ship]
const ORIGIN_POINT = preload("res://Scenes/LevelElements/origin_point.tscn")
const STATION = preload("uid://dadxnsxi1f87y")

signal entering_combat
signal conquered
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
	
	if body is PlayerShip:
		entering_combat.emit()
		for child in Enemy_list:
			child.Target=body
			
			GlobalStuff.player_in_combat.emit()

func guard_destroyed(child_ref:Enemy_ship):
	enemies-=1
	Enemy_list.erase(child_ref)
	
	if enemies<=0:
		print("conquered")
		set_deferred("monitorable",false)
		set_deferred("monitoring",false)
		Conquered=true
		Station.queue_free()
		var safe_Station:Base=STATION.instantiate()
		safe_Station.Staion_Mesh=Station.Friend_mesh
		add_child(safe_Station)
		conquered.emit()


func _on_body_exited(body: Node3D) -> void:
	if body is PlayerShip:
		GlobalStuff.player_away.emit()
