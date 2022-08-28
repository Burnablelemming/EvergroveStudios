extends CanvasLayer

onready var movementPointsLabel = $movementPoints
export var movementPointsNum = 1000
var font
var colorText = Color(0,0,0)

func _ready():
	movementPointsLabel.text = str(movementPointsNum)
	
	var label = Label.new()
	font = label.get_font("")
	label.queue_free()

func update_movement_points(num : int):
	movementPointsNum -= num
	movementPointsLabel.text = str(movementPointsNum)

#func _draw():
#	var source : int = 0
#	var dest : int = 1
#
#	var xVect : float
#	var yVect : float
#	var compVect : Vector2
#	var distVect : float
#
#	for times in (linePairs.size() / 2):
#		#TODO - Something weird is going on here, but it is working to my benefit, but it also eventually needs to be fixed or at least understood
#		xVect = (linePairs[source].get_global_position().x + linePairs[dest].get_global_position().x) / 2
#		yVect = (linePairs[source].get_global_position().y + linePairs[dest].get_global_position().y) / 2
#		compVect = Vector2(xVect, yVect)
#		distVect = abs(linePairs[source].get_global_position().x) + abs(linePairs[dest].get_global_position().x) + abs(linePairs[source].get_global_position().y) + abs(linePairs[dest].get_global_position().y)
#		Root.draw_string(font, compVect, str(distVect), colorText)
