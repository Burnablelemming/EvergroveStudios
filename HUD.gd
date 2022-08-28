extends CanvasLayer

onready var movementPointsLabel = $movementPoints
export var movementPointsNum = 1000

func _ready():
	movementPointsLabel.text = str(movementPointsNum)

func update_movement_points(num : int):
	movementPointsNum -= num
	movementPointsLabel.text = str(movementPointsNum)
