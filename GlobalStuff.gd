extends Node

signal player_away
signal player_in_combat

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
