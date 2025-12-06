extends Control

@export var Boxes:Array[DialogBox]
@export_file_path() var Initial_Level:String
var current_box:int=0
func _ready() -> void:
	for box in Boxes:
		box.hide()
		box.reset_text()
		box.next_pressed.connect(show_next_box)
		box.prev_pressed.connect(show_previous_box)
		
	Boxes[current_box].show()
	Boxes[current_box].play_text()

func show_next_box():
	if current_box<Boxes.size()-1:
		Boxes[current_box].hide()
		current_box+=1
		Boxes[current_box].reset_text()
		Boxes[current_box].show()
		Boxes[current_box].play_text()
	else:
		load_level()

func show_previous_box():
	if current_box>0:
		Boxes[current_box].hide()
		current_box-=1
		Boxes[current_box].reset_text()
		Boxes[current_box].show()
		Boxes[current_box].play_text()
	else:
		print("zero")

func load_level():
	get_tree().change_scene_to_file(Initial_Level)
