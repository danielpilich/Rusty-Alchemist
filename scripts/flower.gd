extends Area2D

func _on_body_entered(body):
	if body.name == "Hero":
		body.add_ingredient()
		queue_free()
