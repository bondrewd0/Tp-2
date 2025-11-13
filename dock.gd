extends Button

func _on_pressed() -> void:
	GlobalStuff.dock.emit()
	hide()
