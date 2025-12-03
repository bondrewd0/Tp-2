extends Resource
class_name Stack

@export var item:Item
@export var amount:int=0

func add_amount(recived:int=0):
	amount+=recived

func spend(price:int=0):
	amount-=price
