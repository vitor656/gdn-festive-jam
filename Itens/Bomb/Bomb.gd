extends KinematicBody2D

const UP = Vector2(0, -1)

export var FallSpeed = 20
var isFalling = false
var motion = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if $RayCast2D.is_colliding():
		if "Player" in $RayCast2D.get_collider().name && !isFalling:
			isFalling = true
			$RayCast2D.enabled = false
			$AnimationPlayer.play("Shake")
	if isFalling:
			move_and_slide(motion, UP)

func _on_animation_finished(anim_name):
	if "Shake" in anim_name:
		motion.y = FallSpeed
		$AnimationPlayer.play("idle")

func _on_body_entered(body):
	if "Player" in body.name:
		body.visible = false
	if isFalling:
		queue_free()
