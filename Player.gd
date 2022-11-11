extends KinematicBody2D

const ZERO = 0

onready var spr = $spr
onready var anim = $anim

#Export Variables
export var gravity = 30
export var speed = 20
export var friction = 20
export var maxAcceleration = 180
export var jumpForce = -400

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
		if(acceleration.x + speed) <= maxAcceleration:
			acceleration.x += speed
		anim.play("walkRight")

	elif Input.is_action_pressed("ui_left"):
		if(acceleration.x - speed) >= -maxAcceleration:
			acceleration.x -= speed
		anim.play("walkLeft")
	else:
		anim.play("Idle")
		applyFriction()
	if Input.is_action_just_pressed("ui_up") and acceleration.y == 0:
		acceleration.y = jumpForce
	
	acceleration.y += gravity

	#TODO - Explain why these are different
	acceleration = move_and_slide(acceleration)
	#move_and_slide(acceleration)
	
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
