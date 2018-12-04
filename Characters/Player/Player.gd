extends KinematicBody2D

const JUMP_FORCE = 300
const UP = Vector2(0, -1)
const GRAVITY = 20

onready var COLLISIONSHAPE = get_node("CollisionShape2D")
onready var CROUCHCOLLISIONSHAPE = get_node("CrouchCollisionShape2D")
onready var SPRITE = get_node("Sprite")
onready var CROUCHSPRITE = get_node("CrouchSprite")

export var speed = 80
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
	if crouch:
		crouch()
	elif crouch_released:
		stand()
	
	motion.x *= speed
	
	move_and_slide(motion, UP)

func crouch():
	SPRITE.visible = false
	CROUCHSPRITE.visible = true
	COLLISIONSHAPE.disabled = true
	CROUCHCOLLISIONSHAPE.disabled = false

func stand():
	SPRITE.visible = true
	CROUCHSPRITE.visible = false
	COLLISIONSHAPE.disabled = false
	CROUCHCOLLISIONSHAPE.disabled = true
	if is_on_ceiling():
		crouch()