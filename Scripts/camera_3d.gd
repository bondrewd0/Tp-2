extends Camera3D
@onready var pivot: Node3D = $".."
@onready var nave: PlayerShip = $"../../Nave"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#global_position = pivot.global_position
	look_at_from_position(pivot.global_position, nave.global_position)
