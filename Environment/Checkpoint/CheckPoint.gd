extends Area2D

func _ready():
	connect("body_entered", self, "_body_entered")
	
func _body_entered(body):
	if "Player" in body.name:
		Global.lastCheckpoint = position