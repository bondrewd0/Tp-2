extends Node3D

var player_ref:PlayerShip=null
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
		GlobalStuff.player_away.emit()
		can_dock=true
	

func dock():
	if not can_dock:
		return
	player_ref.can_control=false
	

func force_dock():
	player_ref.global_position=dock_pos.global_position

func _on_safe_zone_body_exited(body: Node3D) -> void:
	player_ref=null

func free_player():
	BaseUi.hide()
	player_ref.can_control=true
	print("exiting")
