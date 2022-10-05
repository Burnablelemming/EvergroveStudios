extends KinematicBody2D

const ZERO = 0

#Export Variables
export var gravity = 50
export var speed = 10
export var friction = 10
export var maxAcceleration = 75
export var jumpForce = -500

#describes the last direction the player was traveling in
var lastDirection : String
var acceleration = Vector2(0,0)

#Debug Variables###############################################################
var currentPlayerMovement : Vector2

func _ready():
	pass

#UPGRADE - Works, but feels REALLY floaty
func _physics_process(_delta):
	#Left and right movement
	if Input.is_action_pressed("ui_right"):
		acceleration.x += speed
	elif Input.is_action_pressed("ui_left"):
		acceleration.x -= speed
	else:
		applyFriction()
	if Input.is_action_just_pressed("ui_up") and acceleration.y == 0:
		acceleration.y = jumpForce
	
	
	acceleration.y += gravity

	#TODO - Explain why these are different
	acceleration = move_and_slide(acceleration)
	#move_and_slide(acceleration)
	print(acceleration)
	
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

