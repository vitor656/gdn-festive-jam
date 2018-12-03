extends KinematicBody2D

const JUMP_FORCE = 300
const UP = Vector2(0, -1)
const GRAVITY = 20

export var speed = 80
var motion = Vector2()

func _ready():
	pass

func _physics_process(delta):
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	var jump_released = Input.is_action_just_released("ui_accept")
	
	motion.y += GRAVITY
	
	if right:
		motion.x = 1
	elif left:
		motion.x = -1
	else:
		motion.x = 0
		
	if jump && is_on_floor():
		motion.y = -JUMP_FORCE
	elif jump_released && motion.y < 0:
		motion.y = 0
	
	motion.x *= speed
	
	move_and_slide(motion, UP)
