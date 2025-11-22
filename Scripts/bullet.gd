extends RigidBody3D
class_name Bullet

func _on_de_spawner_timeout() -> void:
	queue_free()


func _on_hit_box_body_entered(body: Node3D) -> void:
	#print("hit")
	$DeSpawner.stop()
	queue_free()
