extends Node3D
class_name enemyDrops
@export var Drops:Array[Stack]=[]
var drop_multiplier:int=1
func _ready() -> void:
	print(Drops)
	for object in Drops:
		var drop_amount=randi_range(5,10)
		drop_amount*=drop_multiplier
		print("amo", drop_amount)
		object.add_amount(drop_amount)
		print(object.amount)
