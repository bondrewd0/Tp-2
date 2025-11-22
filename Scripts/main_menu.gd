extends Control
@onready var master: Label = $VolumeMaster/Master
@onready var sfx: Label = $VolumeSFX/SFX
@onready var music: Label = $VolumeMusic/Music
@export_file_path() var Initial_Level:String="res://Scenes/LevelElements/test.tscn"



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(Initial_Level)
	print("asdasdadsads")


func _on_settings_pressed() -> void:
	%MainMenu.hide()
	%SettingsBox.show()
	
func _on_return_pressed() -> void:
	%MainMenu.show()
	%SettingsBox.hide()	
	
func _on_volume_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db(value))
	master.set_text("Master:"+ str(round(value*100)))

func _on_volume_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,linear_to_db(value))
	sfx.set_text("Sfx:"+ str(round(value*100)))

func _on_volume_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,linear_to_db(value))
	music.set_text("Music:"+ str(round(value*100)))
