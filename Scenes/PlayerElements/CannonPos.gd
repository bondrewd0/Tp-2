extends Marker3D
class_name CannonPos
@onready var visual_ref: MeshInstance3D = $VisualRef

func _ready() -> void:
	visual_ref.hide()
