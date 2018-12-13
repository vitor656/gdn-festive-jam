extends Area2D

func _on_Spike_body_entered(body):
	if "Player" in body.name:
		body.die()