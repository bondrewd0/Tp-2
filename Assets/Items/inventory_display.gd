extends Control

@export var ItemFrames:Array[ItemFrame]

func _ready() -> void:
	print("setting up")
	GlobalStuff.update_display.connect(update_display)

func update_display(player_inventory:Array[Stack]):
	print("updating")
	for item in ItemFrames:
		for player_item in player_inventory:
			if item.item.name==player_item.item.name:
				item.update_amount(player_item.amount)
