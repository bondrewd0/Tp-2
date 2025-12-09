extends Node3D
class_name Base
var player_ref:PlayerShip=null
@export var Staion_Mesh:MeshInstance3D=null
@export var BaseUi:Control=null
@onready var dock_pos: Marker3D = $DockPos

var can_dock:bool=false
func _ready() -> void:
	
	GlobalStuff.exit_base.connect(free_player)
	GlobalStuff.dock.connect(dock)
	GlobalStuff.force_Dock.connect(force_dock)
func _on_safe_zone_body_entered(body: Node3D) -> void:
	if body is PlayerShip:
		player_ref=body
		print("safe")
		BaseUi.show()
		BaseUi.player_ref=player_ref
		GlobalStuff.player_away.emit()
		can_dock=true
		print(player_ref)
		print_debug("yo",self)
	

func dock():
	if not player_ref:
		return
	if not can_dock:
		return
	player_ref.can_control=false
	

func force_dock():
	if not player_ref:
		return
	print_debug("yo",self)
	player_ref.global_position=dock_pos.global_position


func _on_safe_zone_body_exited(body: Node3D) -> void:
	print("out of safe")
	if body is PlayerShip:
		player_ref=null
		BaseUi.hide()

func free_player():
	if not player_ref:
		return
	BaseUi.hide()
	player_ref.can_control=true
	print("exiting")

func get_ui(ui:Control):
	BaseUi=ui
