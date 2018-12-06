extends KinematicBody2D

const JUMP_FORCE = 300
const UP = Vector2(0, -1)
const GRAVITY = 20
const LOW_GRAVITY = 20
const NORMAL_SPEED = 80
const CROUCH_SPEED = 20
const SLIPPERY_FACTOR = 1.5
const MAX_FALL_SPEED = 200

onready var COLLISIONSHAPE = $CollisionShape2D
onready var CROUCHCOLLISIONSHAPE = $CrouchCollisionShape2D
onready var SPRITE = $Sprite
onready var ANIM = $AnimationPlayer

onready var tileMap = get_parent().get_node("Map/TileMap")

export var speed = NORMAL_SPEED
var currentSpeed = speed
export (bool) var isCrouched = false
export (bool) var isOnSlipperyFloor = false
export (bool) var isHasty = false
export (bool) var isSlowfall = false
var isMoving = false
var motion = Vector2()

var interactableObject = null

func _ready():
	pass

func _physics_process(delta):
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	var jump_released = Input.is_action_just_released("ui_accept")
	var crouch = Input.is_action_pressed("ui_down")
	var crouch_released = Input.is_action_just_released("ui_down")
	var interact = Input.is_action_just_pressed("ui_up")
	
	if isSlowfall:
		if !is_on_floor():
			motion.y += GRAVITY/2
			motion.y = min(motion.y, MAX_FALL_SPEED/2)
		#else:
		#	motion.y = GRAVITY/2
	else:
		if !is_on_floor():
			motion.y += GRAVITY
			motion.y = min(motion.y, MAX_FALL_SPEED)
		#Pq esse else?
		#else:
		#	motion.y = GRAVITY
	
	if right:
		if isOnSlipperyFloor:
			currentSpeed = speed
		motion.x = 1
		SPRITE.flip_h = false
		isMoving = true
	elif left:
		if isOnSlipperyFloor:
			currentSpeed = speed
		motion.x = -1
		SPRITE.flip_h = true
		isMoving = true
	elif isHasty:
		isMoving = true
		if motion.x < 0:
			motion.x = -1
		else:
			motion.x = 1
	else:
		isMoving = false
		if isOnSlipperyFloor:
			if currentSpeed > 0 && motion.x != 0:
				currentSpeed -= SLIPPERY_FACTOR
				if motion.x >= 0:
					motion.x = 1
				else:
					motion.x = -1
			else:
				motion.x = 0
				currentSpeed = speed;
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
	elif !check_ceiling_on_crouch():
		stand()
	
	if isOnSlipperyFloor:
		motion.x *= currentSpeed
	else:
		motion.x *= speed
	animations()
	move_and_slide(motion, UP)
	
	if interact:
		if interactableObject != null:
			interactableObject.interact()

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
		
func check_ceiling_on_crouch():
	if tileMap.get_cellv(tileMap.world_to_map(position)) > -1:
		return true
	
	return false
	
	
func toggle_animation(animation_name):
	if ANIM.current_animation != animation_name:
		ANIM.play(animation_name)
		
func animations():
	if is_on_floor():
		if isCrouched:
			if isMoving:
				toggle_animation("CrouchWalk")
			else:
				toggle_animation("CrouchIdle")
#			if motion.x >= 1:
#				toggle_animation("CrouchWalk")
#			elif motion.x <= -1:
#				toggle_animation("CrouchWalk")
#			else:
#				toggle_animation("CrouchIdle")
		else:
			if isMoving:
				toggle_animation("Run")
			else:
				toggle_animation("Idle")
#			if motion.x >= 1:d
#				toggle_animation("Run")
#			elif motion.x <= -1:
#				toggle_animation("Run")
#			else:
#				toggle_animation("Idle")
	else:
		if motion.y < 0:
			toggle_animation("JumpUp")
		if motion.y > 0:
			toggle_animation("JumpDown")