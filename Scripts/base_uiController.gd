extends Control

@onready var un_dock: Button = $UnDock
@onready var dock: Button = $Dock
@onready var effect_anim: AnimationPlayer = $Effect/EffectAnim

func _ready() -> void:
	GlobalStuff.dock.connect(on_docking)
	

func _on_visibility_changed() -> void:
	if visible:
		un_dock.hide()
		dock.show()

func on_docking():
	effect_anim.play("FadeOut")
	un_dock.show()
	dock.hide()


func _on_effect_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name=="FadeOut":
		GlobalStuff.force_Dock.emit()
		print("fading in")
		effect_anim.play("FadeIn")
