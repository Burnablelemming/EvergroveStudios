extends CharacterBody2D

const ZERO = 0

@onready var spr = $spr
@onready var anim = $anim


var gravity = 30
var speed = 20
var friction = 20
var maxAcceleration = 180

#Jump-specific vars
var jumpHold = -1
var jumpBurst = -400
var jumpMax = -10
var jumpCur = 0

#describes the last direction the player was traveling in
var lastDirection : String
var acceleration = Vector2(0,0)

#Debug Variables###############################################################
var currentPlayerMovement : Vector2

func _ready():
	pass

func _physics_process(_delta):
	#Left and right movement
	if Input.is_action_pressed("ui_right"):
		if(acceleration.x + speed) <= maxAcceleration:
			acceleration.x += speed
		anim.play("walkRight")
	elif Input.is_action_pressed("ui_left"):
		if(acceleration.x - speed) >= -maxAcceleration:
			acceleration.x -= speed
		anim.play("walkLeft")
	else:
		anim.play("idleRight")
		applyFriction()
	
	#FIXME - You can kinda float checked your way up
	#if acceleration.y is a positive number you are going down
	if Input.is_action_just_pressed("ui_up") and acceleration.y == 0:
		acceleration.y = jumpBurst
	if Input.is_action_pressed("ui_up"):
		if(acceleration.y > 0):
			acceleration.y += gravity
		elif(jumpCur >= jumpMax):
			acceleration.y += jumpHold
			jumpCur += jumpHold
			print("Cur Jump = ", jumpCur, "maxJump = ", jumpMax)
		else:
			acceleration.y += gravity
		print(acceleration)
	else:
		jumpCur = 0
		acceleration.y += gravity


	#TODO - Explain why these are different
	set_velocity(acceleration)
	move_and_slide()
	acceleration = velocity
	set_velocity(acceleration)
	move_and_slide()
	#velocity
	
func applyFriction():
	#print("was called")
	#If player is moving
	if acceleration.x != 0:
		#print("accel not zero")
		#Player was moving right
		if acceleration.x > 0:
			#print("moving right")
			acceleration.x -= friction
		#Player was moving left
		elif acceleration.x < 0:
			#print("moving right")
			acceleration.x += friction
	#accel was zero
	else:
		return
