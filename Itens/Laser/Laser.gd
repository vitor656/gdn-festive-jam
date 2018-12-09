extends Area2D

var speed = 30

func _physics_process(delta):
	move_local_x( speed * delta )

func _on_Laser_body_entered(body):
	if not "Player" in body.name:
		queue_free()