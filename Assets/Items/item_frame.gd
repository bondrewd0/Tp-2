extends TextureRect
class_name ItemFrame
@export var item:Item
@onready var amount_text: RichTextLabel = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture=item.texture

func update_amount(amount:int=0):
	print("changing amount")
	amount_text.text="X%d"%amount
