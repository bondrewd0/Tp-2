extends Control

@onready var master: Label = $SettingsMenu/VolumeMaster/Master
@onready var sfx: Label = $SettingsMenu/VolumeSFX/SFX
@onready var music: Label = $SettingsMenu/VolumeMusic/Music
# Called when the node enters the scene tree for the first time.


#unificarlo en la funcion main_menu.gd
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
