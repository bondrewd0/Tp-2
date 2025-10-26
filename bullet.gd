extends RigidBody3D


func _on_de_spawner_timeout() -> void:
	queue_free()


func _on_hit_box_body_entered(body: Node3D) -> void:
	#print("hit")
	$DeSpawner.stop()
	queue_free()
