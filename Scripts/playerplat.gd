extends KinematicBody2D

#Export Variables
#1, 10, 30 are way to fucking slow
# is a bit slow
export var GRAVITY = 50

const ZERO = 0

#1, 10 are way to fucking slow
#100 is a bit fast
export var speed = 5
export var friction = 15
export var maxAcceleration = 75
export var jumpForce = 50

var acceleration = 0

#describes the last direction the player was traveling in
var lastDirection : String

#Debug Variables###############################################################
var currentPlayerMovement : Vector2

func _ready():
	pass

#UPGRADE - Works, but feels REALLY floaty
func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		if acceleration < maxAcceleration:
			acceleration += speed
	elif Input.is_action_pressed("ui_left"):
		if acceleration > (-maxAcceleration):
			acceleration -= speed
	elif Input.is_action_just_pressed("ui_up"):
		move_and_slide(Vector2(0,jumpForce))
		print("jumping")
		
	else:
		if acceleration < 0:
			acceleration += friction
		elif acceleration > 0:
			acceleration -= friction
	currentPlayerMovement = move_and_slide(Vector2(acceleration,GRAVITY))
	
	print(acceleration)

