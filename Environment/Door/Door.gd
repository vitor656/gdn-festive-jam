extends KinematicBody2D

func _ready():
	$AnimationPlayer.play("Closed")
	
func open():
	$AnimationPlayer.play("Open")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open":
		$CollisionShape2D.disabled = true