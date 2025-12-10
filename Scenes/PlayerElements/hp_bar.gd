extends TextureProgressBar

@export var Player_ref:PlayerShip
@onready var text_val: RichTextLabel = $TextVal

func _ready() -> void:
	UpgradesManager.mod_max_hp_bar.connect(change_max_val)
	Player_ref.hp_changed.connect(player_hp_changed)
	max_value=Player_ref.HP
	value=Player_ref.HP
	set_text(value,max_value)

func change_max_val():
	max_value=Player_ref.HP
	set_text(value,max_value)

func player_hp_changed():
	value=Player_ref.current_hp
	set_text(value,max_value)

func set_text(current_val:float,max_val:float):
	text_val.text="%d/%d"%[current_val,max_val]
