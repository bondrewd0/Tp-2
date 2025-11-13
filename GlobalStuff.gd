extends Node

signal player_away
signal player_in_combat
signal exit_base
signal dock
signal force_Dock
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
