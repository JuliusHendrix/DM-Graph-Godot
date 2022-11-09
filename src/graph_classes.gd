# graph base class
class Graph:
	var name : String
	var nodes : Array
	var edges : Array
	
	func _init(name : String, nodes : Array = [], edges : Array = []):
		self.name = name
		self.nodes = nodes
		self.edges = edges

# edge base class
class GEdge:
	extends Node2D
	
	var type = ["GEdge"]
	
	var sender : GNode
	var receiver : GNode
	
	var color : Color = Color(0, 0, 0, 1)
	var width : float = 1.5

	func _init(sender, receiver):
		self.sender = sender
		self.receiver = receiver

	func _draw():
		draw_line(sender.position, receiver.position, color, width)

# node base class
class GNode:
	extends Area2D
	
	# utility parameters
	var mouse_over_prev = false
	var mouse_over = false
	var graph_manager
	var child_node
	
	# node parameters
	var type : Array = ["GNode"]
	var neighbours : Array
	var edges : Array = []
	
	# draw parameters
#	var radius : float = 10.0
#	var color : Color = Color( 0.5, 1, 0.83, 1 )

	func _init(graph_manager, name, neighbours, position):
		self.graph_manager = graph_manager
		
		self.name = name
		self.neighbours = neighbours
		self.position = position
		
		# instantiate template node
		child_node = graph_manager.get_node("TemplateGraph").get_node("GraphNode").duplicate()
		child_node.visible = true
		child_node.get_node("LabelName").text = name
		self.add_child(child_node)
	
	func _ready():
		# set the collision shape
		var shape = CircleShape2D.new()
#		shape.set_radius(radius)
#		self.get_child(0).shape = shape    # this may break if more children are added
		
		# setup mouse click detection
		child_node.connect("mouse_entered", self, "_mouse_over", [true])
		child_node.connect("mouse_exited", self, "_mouse_over", [false])

		set_process_unhandled_input(true)

	# track over which node we are hovering
	func _mouse_over(value):
		self.mouse_over_prev = self.mouse_over
		self.mouse_over = value
		
		if self.mouse_over_prev == false and self.mouse_over == true:
			self.graph_manager.above_gnode = self
		elif self.mouse_over_prev == true and self.mouse_over == false:
			self.graph_manager.above_gnode = null

# basic place class
class Place:
	extends GNode
	
	func _init(graph_manager, name, neighbours, position).(graph_manager, name, neighbours, position):
		self.type.append("Place")
		self.child_node.get_node("Sprite").texture = load("res://images/place.png")


# basic actor class
class Actor:
	extends GNode
	
	func _init(graph_manager, name, neighbours, position).(graph_manager, name, neighbours, position):
		self.type.append("Actor")
		self.child_node.get_node("Sprite").texture = load("res://images/person.png")
