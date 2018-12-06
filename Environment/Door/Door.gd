extends KinematicBody2D

func _ready():
	$AnimationPlayer.play("Closed")
	
func open():
	$AnimationPlayer.play("Open")
	$CollisionShape2D.disabled = true