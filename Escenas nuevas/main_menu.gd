extends Control
@onready var master: Label = $VolumeMaster/Master
@onready var sfx: Label = $VolumeSFX/SFX
@onready var music: Label = $VolumeMusic/Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://test.tscn")


func _on_settings_pressed() -> void:
	%MainMenu.hide()
	%SettingsBox.show()
	
func _on_volume_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db(value))
	master.set_text("Master:"+ str(round(value*100)))

func _on_volume_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,linear_to_db(value))
	sfx.set_text("Sfx:"+ str(round(value*100)))

func _on_volume_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,linear_to_db(value))
	music.set_text("Music:"+ str(round(value*100)))


func _on_return_pressed() -> void:
	%MainMenu.show()
	%SettingsBox.hide()
