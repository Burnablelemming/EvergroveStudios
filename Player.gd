extends KinematicBody2D

var rotationTargets : Array
var currentTarget : int = 0
var targetsCount : int
var initalCheck : int = 1
var tween

var HUD : CanvasLayer

func _ready():
	tween = get_node("Tween")
	
	rotation += 0.1
	print(rotation)

#When using KinematicBody2D you should use _physics_process
#It's called the same amount of times per second, always. 
#This makes physics and motion calculation work in a more predictable way
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_right"):
		print("Button hit but does move")
		if targetsCount == 1:
			currentTarget = 0
		elif targetsCount == 2:
			if currentTarget == 0:
				currentTarget = 1
			else:
				currentTarget = 0
		elif targetsCount > 2:
			if currentTarget + 1 == targetsCount:
				currentTarget = 0
			else:
				currentTarget += 1
		#print("Current target: ", currentTarget, rotationTargets[currentTarget].get_global_position())
#		look_at(rotationTargets[currentTarget].get_global_position())

		tween.interpolate_property(self, "rotation", rotation, position.angle_to_point(rotationTargets[currentTarget].get_global_position()), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.start()
#
	if Input.is_action_just_pressed("ui_accept"):
		tween.interpolate_property(self, "position", position, rotationTargets[currentTarget].get_global_position(), 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
		tween.start()

func _on_Area2D_area_entered(area):
	rotationTargets.clear()
	targetsCount = 0
	
	for child in area.get_children():
		if child is Area2D:
			rotationTargets.append(child)
	if area.get_parent() is Area2D:
		rotationTargets.push_front(area.get_parent())
	
	currentTarget = 0
	targetsCount = rotationTargets.size()
	#print(rotationTargets)
	#look_at(rotationTargets[currentTarget].get_global_position())
	initalCheck = 0
