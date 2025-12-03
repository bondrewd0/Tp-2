extends Resource
class_name Upgrade_req
@export var Requiered_items:Array[Ingredient]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ingredient in Requiered_items:
		print(ingredient.item.name,", ",ingredient.Requiered)
