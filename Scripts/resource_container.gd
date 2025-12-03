extends Node3D
class_name ResContainer
@export var Inventory:Array[Stack]=[]

func _ready() -> void:
	GlobalStuff.sendloot.connect(recieve_drops)
	
	print("Starting inventory")
	for object in Inventory:
		print(object.item.name," ", object.amount)
	GlobalStuff.update_display.emit(Inventory)

func recieve_drops(drops:Array[Stack]):
	print("recived")
	for object in drops:
		for item in Inventory:
			if object.item.name==item.item.name:
				print("yes")
				item.add_amount(object.amount)
				print(item.item.name,", ",item.amount)
	GlobalStuff.update_display.emit(Inventory)
