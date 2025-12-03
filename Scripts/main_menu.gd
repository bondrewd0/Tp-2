extends Control

@export_file_path() var Initial_Level:String="res://Scenes/LevelElements/test.tscn"



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(Initial_Level)



func _on_settings_pressed() -> void:
	%MainMenu.hide()
	%SettingsBox.show()
	
func _on_return_pressed() -> void:
	%MainMenu.show()
	%SettingsBox.hide()	
	
