extends Node2D

onready var camera = $Camera2D
onready var player = $Player
onready var start = $start

var currentNode : Area2D    #visitTree - Used to track where we are in the tree
var visited : Array         #visitTree - Used to track where we have been in the tree
var children : Array        #visitTree - Used to understand our surroundings in the tree
var extraChildren : int = 2 #visitTree - Used to define how many children the nodes on the tree have that arent Area2D's
var treeData : Array        #visitTree - The result of the depth first search

var colorLines = Color(255,255,255)

# Called when the node enters the scene tree for the first time.
func _ready():
	currentNode = start
	visited.append(start)
	visitTree()
	update()
	
#This function's purpose is to preform a depth first search on the skill tree I have set up and do a couple things:
   #The first thing is to grab all the children of each node which are Area2D's and put them in an array called visited
   #The second thing is to add the structure (which nodes connect to which nodes) to an array called treeData
func visitTree():
	for child in currentNode.get_children():
		if child is Area2D:
			children.append(child)
	for child in children:
		if visited.has(child):
			if children.find(child) == children.size() - 1:
				if currentNode == start:
					children.clear()
					return
				children.clear()
				currentNode = child.get_parent().get_parent()
				visitTree()
		else:
			visited.append(child)
			if child.get_child_count() > extraChildren:
				treeData.append(currentNode)
				treeData.append(child)
				children.clear()
				currentNode = child
				visitTree()
			else:
				treeData.append(currentNode)
				treeData.append(child)
				if children.find(child) == children.size() - 1:
					children.clear()
					visitTree()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Setting the cameras position to the players position every frame
	#camera variable must be set to current in right panel for this to work
	camera.set_position(player.get_position())

func _draw():
	if treeData.empty():
		return

	var source : int = 0
	var dest : int = 1
	for times in (treeData.size() / 2.0):
		draw_line(treeData[source].get_global_position(), treeData[dest].get_global_position(), colorLines, 4)
		source += 2
		dest += 2
