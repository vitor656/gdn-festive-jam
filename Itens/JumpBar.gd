extends Area2D

export var JumpForce = 600

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(obj):
	if "Player" in obj.name:
		obj.motion.y = -JumpForce
		$AnimationPlayer.play("Triggered")
		$AnimationPlayer.queue("idle")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass