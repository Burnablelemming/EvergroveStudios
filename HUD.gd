extends CanvasLayer

onready var movementPointsLabel = $movementPoints
export var movementPointsNum = 1000

func _ready():
	movementPointsLabel.text = str(movementPointsNum)

func update_labels():
	movementPointsNum -= 10
	movementPointsLabel.text = str(movementPointsNum)

func update_numbers(num : int):
	pass
