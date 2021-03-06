extends Area2D

export var destinyId = 0

onready var destinyPortal = get_parent().get_node("Portal" + str(destinyId))

var onCooldown = false

func _on_body_entered(body):
	if "Player" in body.name && !onCooldown:
		body.position = destinyPortal.position
		destinyPortal.onCooldown = true
		$EnteringParticles.emitting = false
		$EnteringParticles.emitting = true
		destinyPortal.get_node("LeavingParticles").emitting = false
		destinyPortal.get_node("LeavingParticles").emitting = true

func _on_body_exited(body):
	if "Player" in body.name:
		onCooldown = false