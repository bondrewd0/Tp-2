extends TextureRect
class_name DialogBox
var text_tween:Tween
@onready var dialogue: RichTextLabel = $Dialogue
@onready var prev_scene: TextureButton = $PrevScene
@onready var next_scene: TextureButton = $NextScene
@onready var exit: Button = $Exit

signal next_pressed
signal prev_pressed

@export var Text2Display:String

func reset_text():
	dialogue.visible_ratio=0.0

func play_text():
	print(dialogue.text.length())
	dialogue.text=Text2Display
	text_tween=create_tween()
	text_tween.tween_property(dialogue,"visible_ratio",1.0,2)

func _on_prev_scene_pressed() -> void:
	prev_pressed.emit()

func _on_next_scene_pressed() -> void:
	next_pressed.emit()


func _on_exit_pressed() -> void:
	get_tree().quit()
