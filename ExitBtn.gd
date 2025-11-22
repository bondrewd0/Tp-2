extends Button


func _on_pressed() -> void:
	GlobalStuff.exit_base.emit()
	print("test")
