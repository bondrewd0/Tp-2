extends TextureRect
class_name IngredientFrame
@export var ingredient:Ingredient
@onready var text: RichTextLabel = $RichTextLabel

func set_frame_texture():
	texture=ingredient.item.texture

func set_text():
	text.text="X%d"%ingredient.Requiered
