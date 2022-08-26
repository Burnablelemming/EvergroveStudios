extends Node2D

onready var camera = $Camera2D
onready var player = $Player
onready var start = $start
onready var expts = $CanvasLayer/experiencePts

var col = Color(255,255,255)
var extraChildren : int = 2

func connect_to_HUD():
	$CanvasLayer.update_labels()

# Called when the node enters the scene tree for the first time.
# So far, this is only ever called once
func _ready():
	currentNode = start
	visited.append(start)
	visitTree()
	#print("Success!")
	#print()
	#print("Line Pairings: ", linePairs)
	#print()
	#print("Visited: ", visited)
	_draw()

#This function's purpose is to preform a depth first search on the skill tree I have set up and do a couple things:
   #The first thing is to grab all the children of each node which are Area2D's and put them in an array called visited
   #The second thing is to add the structure (which nodes connect to which nodes) to an array called linePairs

var currentNode : Area2D #Used to track where we are in the tree
var visited : Array      #Used to track where we have been in the tree
var children : Array     #Used to understand our surroundings in the tree
func visitTree():
	#print("---------------------------------------")
	#print("CurrentNode: ", currentNode.name)
	for child in currentNode.get_children():
		if child is Area2D:
			children.append(child)
	for child in children:
		if visited.has(child):
			#print("   Node ", child, " has been visited before")
			if children.find(child) == children.size() - 1:
				if currentNode == start:
					#print("All nodes in the tree have been documented - EXIT NOW")
					children.clear()
					return
				#print("   Every node on this branch has been visited")
				children.clear()
				currentNode = child.get_parent().get_parent()
				visitTree()
		else:
			#print("   Selected node: ", currentNode.name, " and current child: ", child.name)
			visited.append(child)
			if child.get_child_count() > 2:
				linePairs.append(currentNode)
				linePairs.append(child)
				#print("      Child: ", child.name, " has useful children - setting currentNode")
				children.clear()
				currentNode = child
				visitTree()
			else:
				#print("      Child: ", child.name, " was a leaf node")
				linePairs.append(currentNode)
				linePairs.append(child)
				if children.find(child) == children.size() - 1:
					children.clear()
					#print("         All children were leaf nodes")
					currentNode = child.get_parent()
					visitTree()

#_draw is called after ready automatically

var linePairs : Array #used to understand what nodes connect and to where
var check : bool = false
func _draw():
	var source : int = 0
	var dest : int = 1
	if check == false:
		check = true
		return
	else:
		#Because parents and children have an interesting connection when it comes to position data
		#it is required that the source and dest position be added together
		for times in (linePairs.size() / 2):
			#print("Drawing from ", linePairs[source].name, " at position ", linePairs[source].get_global_position(), " ***** to ", linePairs[dest].name, " at position ", linePairs[dest].get_global_position())
			draw_line(linePairs[source].get_global_position(), linePairs[dest].get_global_position(), col, 2)
			source += 2
			dest += 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Setting the cameras position to the players position every frame
	#camera variable must be set to current in right panel for this to work
	camera.set_position(player.get_position())
