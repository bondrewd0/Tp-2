extends Control
class_name PlayerStats

@onready var speed_bar: TextureProgressBar = %SpeedBar
@onready var hp_bar: TextureProgressBar = %HpBar
@onready var cannons: RichTextLabel = %Cannons
@onready var cannon_count: RichTextLabel = %CannonCount
@onready var vessel: RichTextLabel = %Vessel
@onready var vessel_type: RichTextLabel = %VesselType

func _ready() -> void:
	load_variables()


func load_variables():
	print("updating")
	speed_bar.max_value=UpgradesManager.Max_speed_upgrades
	speed_bar.value=UpgradesManager.current_speed_upgrade
	hp_bar.max_value=UpgradesManager.Max_HP_upgrades
	hp_bar.value=UpgradesManager.current_hp_upgrade
	cannon_count.text="%1.1f/%d"%[UpgradesManager.current_fire_rate,2]
	vessel_type.text="%d/3"%[UpgradesManager.Current_ship+1]
