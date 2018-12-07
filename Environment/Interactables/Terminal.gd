extends Node2D

export (Array, int) var doorsID
var interactionDone = false

func interact():
	if !interactionDone:
		for id in doorsID:
			var door = get_parent().get_node("Doors/Door" + str(id))
			if door != null:
				door.open()
		
		interactionDone = true



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.interactableObject = self


func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		body.interactableObject = null
