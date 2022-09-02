extends KinematicBody2D

func _ready():
	pass

func _physics_process(delta):
	move_and_slide(Vector2(0,10))
