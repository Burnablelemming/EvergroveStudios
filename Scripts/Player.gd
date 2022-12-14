extends CharacterBody2D

const ZERO = 0

@onready var spr:Sprite2D = $spr
@onready var anim:AnimationPlayer = $anim
@onready var chara:CharacterBody2D = get_node(".")

#Gravity defines how fast you fall
#Speed is how fast you reach max speed
#Friction is how fast you stop moving
#maxAcceleration is how fast you can possible move horizontally
var gravity = 20
var normalForce = -20
var speed = 40
var friction = 40
var maxHorizontalAcceleration = 200

var maxDownwardAcceleration = -200
var maxUpwardAcceleration = 200 

#Jump-specific vars

#The force of the initial jump (no hold, one tap)
var jumpBurst = -275

########
var jumpHold = 0

#Max time value until you run out of boost
var jumpHoldMax = 15

#How much the timer incriments each frame (probably dont need to touch)
var jumpHoldIncri = 1

#How many pixels you actually move
var jumpBoost = -20

#describes the last direction the player was traveling in
var lastDirection : String
var acceleration = Vector2(0,0)

func _ready():
	pass

func _physics_process(_delta):
	move_and_stuff()
	apply_gravity_normal()
	
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
		#anim.play("idle")
		applyFriction()
		
		
	if Input.is_action_pressed("ui_up"):
		if(chara.is_on_floor()):
			jumpHold = 0
			acceleration.y += jumpBurst
		else:
			if(jumpHold < jumpHoldMax):
				acceleration.y += jumpBoost
				jumpHold += jumpHoldIncri
			else:
				print("out of boost")
		print("should be playing anim")
		anim.play("jump")
	
	
func apply_gravity_normal():
	if(chara.is_on_floor() == false):
			acceleration.y += gravity
			print("Gravity", acceleration)
	else:
		while(acceleration.y != 0):
			if(acceleration.y + normalForce < 0):
				acceleration.y = 0
				print("Normal Reset")
			else:	
				acceleration.y += normalForce
				print("Normal", acceleration)
				
	#gravity must be a constant force, otherwise you can just never let accel.y decrease by holding the buttons

func move_and_stuff():
	set_velocity(acceleration)
	move_and_slide()

func applyFriction():
	if acceleration.x != 0:
		if acceleration.x > 0:
			acceleration.x -= friction
		elif acceleration.x < 0:
			acceleration.x += friction
	else:
		return
