extends Area3D

@export var Designated_Ship:Enemy_ship=null
var can_heal:bool=false

func _ready() -> void:
	GlobalStuff.player_away.connect(out_of_combat)
	GlobalStuff.player_in_combat.connect(in_combat)

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy_ship and body==Designated_Ship:
			if can_heal:
				body.Heal_up()

func in_combat():
	can_heal=false

func out_of_combat():
	can_heal=true
