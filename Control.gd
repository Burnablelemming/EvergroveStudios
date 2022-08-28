extends Control

var treeData : Array
var colorLines = Color(255,255,255)

func _ready():
	update()

func _draw():
	if treeData.empty():
		return
	var source : int = 0
	var dest : int = 1

	for times in (treeData.size() / 2):
		draw_line(treeData[source].get_global_position(), treeData[dest].get_global_position(), colorLines, 2)
		source += 2
		dest += 2

func _on_Root_tree_data(data):
	treeData = data
