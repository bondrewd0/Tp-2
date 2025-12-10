extends TextureButton
class_name Upg_Btn
@export_enum("Speed","Health", "Cannons", "Vessel") var UpgradeType:String
@export var Upgrade:Upgrade_req
@export var StatIncrease:float
@onready var text: RichTextLabel = $Text
@export var FramePath:PackedScene
var can_purchase:bool=true
var copy_inventory:Array[Stack]
signal  make_purchase(objects:Upgrade_req)
@onready var ingredientsContainer: HBoxContainer = $Ingredients
@onready var plus_simbol: TextureRect = $PlusSimbol

var abled:Color=Color("009b40")
var disabled_color:Color=Color("53575fff")
func _ready() -> void:
	text.text=UpgradeType+" upgrade"
	for ingredient in Upgrade.Requiered_items:
		var frame_ins=FramePath.instantiate()
		if frame_ins is IngredientFrame:
			frame_ins.ingredient=ingredient
			ingredientsContainer.add_child(frame_ins)
			frame_ins.set_frame_texture()
			frame_ins.set_text()

func check_purchasable(player_inventory:Array[Stack]):
	can_purchase=check_avaible()
	if not can_purchase:
		disabled= !can_purchase
		self_modulate=disabled_color
		text.modulate=disabled_color
		plus_simbol.modulate=disabled_color
		return
	for ingredient in Upgrade.Requiered_items:
		#print("needs: ",ingredient.item.name,", ", ingredient.Requiered)
		for player_item in player_inventory:
			#print("has: ",player_item.item.name,", ",player_item.amount)
			if ingredient.item.name==player_item.item.name:
				#print("has item")
				if ingredient.Requiered>player_item.amount:
					can_purchase=false
	#print("can purchase: ",can_purchase)
	if not can_purchase:
		disabled=true
		self_modulate=disabled_color
		text.modulate=disabled_color
		plus_simbol.modulate=disabled_color
	else:
		disabled=false
		self_modulate=abled
		text.modulate=abled
		plus_simbol.modulate=abled


func _on_pressed() -> void:
	print("check")
	send_upgrade()
	make_purchase.emit(Upgrade)
	

func check_avaible():
	print("check2")
	match UpgradeType:
		"Speed" :
			return UpgradesManager.current_speed_upgrade<=UpgradesManager.Max_speed_upgrades
		"Health":
			return UpgradesManager.current_hp_upgrade<=UpgradesManager.Max_HP_upgrades
		"Cannons":
			return UpgradesManager.current_cannons<=UpgradesManager.Cannon_counter
		"Vessel":
			
			return UpgradesManager.Current_ship<2

func send_upgrade():
	match UpgradeType:
		"Speed":
			UpgradesManager.upgrade_speed(StatIncrease)
		"Health":
			UpgradesManager.upgrade_health(StatIncrease)
		"Cannons":
			UpgradesManager.increase_turrets(StatIncrease)
		"Vessel":
			UpgradesManager.upgrade_vessel()
			
