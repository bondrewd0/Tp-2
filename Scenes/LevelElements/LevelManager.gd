extends Node3D
@export var EnemyStations:Array[CombatZone]
@export var UI:Control=null
@onready var effect_anim: AnimationPlayer = $Effect/EffectAnim

var conquered_count:int=0

func _ready() -> void:
	for zone in EnemyStations:
		zone.conquered.connect(check_victory)

func check_victory():
	for zone in EnemyStations:
		if zone.Conquered:
			for station in zone.get_children():
				if station is Base:
					station.BaseUi=UI
					print("ta")
			conquered_count+=1
			print("Progress+1")
		else:
			conquered_count=0
	if conquered_count==EnemyStations.size():
		print("victory")
		effect_anim.play("FadeOutWin")
		
		#Win
func change_level_win():
	get_tree().change_scene_to_file("res://Scenes/LevelElements/Win.tscn")
