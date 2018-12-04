extends KinematicBody2D

const JUMP_FORCE = 300
const UP = Vector2(0, -1)
const GRAVITY = 20
const NORMAL_SPEED = 80
const CROUCH_SPEED = 20

onready var COLLISIONSHAPE = $CollisionShape2D
onready var CROUCHCOLLISIONSHAPE = $CrouchCollisionShape2D
onready var SPRITE = $Sprite
onready var ANIM = $AnimationPlayer

var speed = NORMAL_SPEED
var isCrouched = false
var motion = Vector2()

func _ready():
	pass

func _physics_process(delta):
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	var jump_released = Input.is_action_just_released("ui_accept")
	var crouch = Input.is_action_just_pressed("ui_down")
	var crouch_released = Input.is_action_just_released("ui_down")
	
	if !is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = GRAVITY
	
	if right:
		motion.x = 1
		SPRITE.flip_h = false
	elif left:
		motion.x = -1
		SPRITE.flip_h = true
	else:
		motion.x = 0
		
	if jump && is_on_floor():
		motion.y = -JUMP_FORCE
	elif jump_released && motion.y < 0:
		motion.y = 0
		
	if is_on_ceiling():
		motion.y = 0
		
	if crouch:
		crouch()
	elif crouch_released:
		stand()
	
	motion.x *= speed
	
	animations()
	move_and_slide(motion, UP)

func crouch():
	COLLISIONSHAPE.disabled = true
	CROUCHCOLLISIONSHAPE.disabled = false
	isCrouched = true
	speed = CROUCH_SPEED

func stand():
	COLLISIONSHAPE.disabled = false
	CROUCHCOLLISIONSHAPE.disabled = true
	isCrouched = false
	speed = NORMAL_SPEED
	if is_on_ceiling():
		crouch()
		
func toggle_animation(animation_name):
	if ANIM.current_animation != animation_name:
		ANIM.play(animation_name)
		
func animations():
	if is_on_floor():
		if isCrouched:
			if motion.x >= 1:
				toggle_animation("CrouchWalk")
			elif motion.x <= -1:
				toggle_animation("CrouchWalk")
			else:
				toggle_animation("CrouchIdle")
		else:
			if motion.x >= 1:
				toggle_animation("Run")
			elif motion.x <= -1:
				toggle_animation("Run")
			else:
				toggle_animation("Idle")
	else:
		if motion.y < 0:
			toggle_animation("JumpUp")
		if motion.y > 0:
			toggle_animation("JumpDown")