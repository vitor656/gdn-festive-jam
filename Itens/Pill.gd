extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")
	$AnimationPlayer.play("Default")
	
func _on_body_entered(obj):
	if "Player" in obj.name:
		queue_free()
