extends KinematicBody2D

var rotationTargets : Array
var currentTarget : int = 0
var targetsCount : int
var initalCheck : int = 1

func _ready():
	pass
	#TODO - We have to find a way to tell the canvas layer that we are moving
	#TODO - this is to update the text label
	#TODO - I think we can do this by calling a function from here that goes to the Root.gd
	#TODO - then that function calls a function from there into the canvas layer
	
	#get_parent().connect_to_HUD()
	#FIXME - Nope, dont do any of that crap above, figure out how to make this work better
	get_parent().get_child(0).update_labels()
	

#When using KinematicBody2D you should use _physics_process
#It's called the same amount of times per second, always. 
#This makes physics and motion calculation work in a more predictable way
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_right"):
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
		print("Current target: ", currentTarget, rotationTargets[currentTarget].get_global_position())
		look_at(rotationTargets[currentTarget].get_global_position())
	
	if Input.is_action_just_pressed("ui_accept"):
		var tween = get_node("Tween")
		tween.interpolate_property(self, "position", position, rotationTargets[currentTarget].get_global_position(), 3, Tween.TRANS_QUINT, Tween.EASE_OUT)
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
	print(rotationTargets)
	look_at(rotationTargets[currentTarget].get_global_position())
	initalCheck = 0
