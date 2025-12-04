extends Control

@onready var un_dock: Button = $UnDock
@onready var dock: Button = $Dock
@onready var effect_anim: AnimationPlayer = $Effect/EffectAnim
@onready var vessel_stats: PlayerStats = $VesselStats

@export var Upgrades:Array[Upg_Btn]
var player_ref:PlayerShip=null
func _ready() -> void:
	GlobalStuff.dock.connect(on_docking)
	GlobalStuff.exit_base.connect(on_undocking)
	for btn in Upgrades:
		btn.make_purchase.connect(purchase)

func _on_visibility_changed() -> void:
	if visible:
		un_dock.hide()
		dock.show()

func on_docking():
	effect_anim.play("FadeOut")
	
	dock.hide()
	

func on_undocking():
	vessel_stats.hide()
	for btn in Upgrades:
		btn.hide()

func _on_effect_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name=="FadeOut":
		GlobalStuff.force_Dock.emit()
		print("fading in")
		effect_anim.play("FadeIn")
	if anim_name=="FadeIn":
		player_ref.rotation=Vector3(0,0,0)
		un_dock.show()
		vessel_stats.show()
		for btn in Upgrades:
			btn.show()
			btn.check_purchasable(player_ref.Inventory.Inventory)


func purchase(upgrade_req:Upgrade_req):
	for item in player_ref.Inventory.Inventory:
		for ingredient in upgrade_req.Requiered_items:
			if item.item.name==ingredient.item.name:
				print("spending: ",item.item.name,", ", item.amount)
				item.spend(ingredient.Requiered)
				print("left: ",item.item.name,", ", item.amount)
	for btn in Upgrades:
		btn.check_purchasable(player_ref.Inventory.Inventory)
	vessel_stats.load_variables()
	GlobalStuff.update_display.emit(player_ref.Inventory.Inventory)
