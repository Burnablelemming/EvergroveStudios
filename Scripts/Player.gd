extends CharacterBody2D

const ZERO = 0

@onready var spr:Sprite2D = $spr
@onready var anim:AnimationPlayer = $anim
@onready var chara:CharacterBody2D = get_node(".")

#Gravity defines how fast you fall
#Speed is how fast you reach max speed
#Friction is how fast you stop moving
#maxAcceleration is how fast you can possible move horizontally
var gravity = 1
var normalForce = -1
var speed = 40
var friction = 40
var maxHorizontalAcceleration = 200

var maxDownwardAcceleration = -200
var maxUpwardAcceleration = 200 

#Jump-specific vars
var jumpBurst = -100
var jumpHold = 0
var jumpHoldMax = 200

#describes the last direction the player was traveling in
var lastDirection : String
var acceleration = Vector2(0,0)

#Debug Variables
var currentPlayerMovement : Vector2

func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		if(acceleration.x + speed) <= maxHorizontalAcceleration:
			acceleration.x += speed
		spr.flip_h = false
		anim.play("walk_right")
	elif Input.is_action_pressed("ui_left"):
		if(acceleration.x - speed) >= -maxHorizontalAcceleration:
			acceleration.x -= speed
		spr.flip_h = true
		anim.play("walk_right")
	else:             
		anim.play("idle")
		applyFriction()

	#JUMPING CODE
	if Input.is_action_pressed("ui_up"):
		if(chara.is_on_floor()):
			acceleration.y += jumpBurst
		jumpHold = jumpHold + 1
		print("Holding", jumpHold)
	else:	
		print("released")
		if(chara.is_on_floor() == false):
				acceleration.y += gravity
		else:
			while(acceleration.y != 0):
				acceleration.y += normalForce

	#TODO - Explain why these are different
#	set_velocity(acceleration)
#	move_and_slide()
#	acceleration = velocity
#	set_velocity(acceleration)
#	move_and_slide()

	set_velocity(acceleration)
	#print(velocity)
	move_and_slide()

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
