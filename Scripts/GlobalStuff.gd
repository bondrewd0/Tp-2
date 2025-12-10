extends Node

signal player_away
signal player_in_combat
signal exit_base
signal dock
signal force_Dock
signal sendloot(resources:Array[Stack])
signal update_display(inventory:Array[Stack])
signal player_dead
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
