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
	var graph_utils
	
	# node parameters
	var type : Array = ["GNode"]
	var neighbours : Array
	var edges : Array = []
	
	# draw parameters
	var radius : float = 10.0
	var color : Color = Color( 0.5, 1, 0.83, 1 )

	func _init(graph_utils, name, neighbours, position):
		self.graph_utils = graph_utils
		
		self.name = name
		self.neighbours = neighbours
		self.position = position
		
		# add collision shape
		var coll = CollisionShape2D.new()
		self.add_child(coll)
	
	func _ready():
		# set the collision shape
		var shape = CircleShape2D.new()
		shape.set_radius(radius)
		self.get_child(0).shape = shape    # this may break if more children are added
		
		# setup mouse click detection
		connect("mouse_entered", self, "_mouse_over", [true])
		connect("mouse_exited", self, "_mouse_over", [false])

		set_process_unhandled_input(true)

	func _draw():
		# draw the circle
		draw_circle(Vector2(0,0), radius, color)

	# track over which node we are hovering
	func _mouse_over(value):
		self.mouse_over_prev = self.mouse_over
		self.mouse_over = value
		
		if self.mouse_over_prev == false and self.mouse_over == true:
			self.graph_utils.above_gnode = self
		elif self.mouse_over_prev == true and self.mouse_over == false:
			self.graph_utils.above_gnode = null

# basic place class
class Place:
	extends GNode
	
	func _init(graph_utils, name, neighbours, position).(graph_utils, name, neighbours, position):
		self.type.append("Place")
		self.color = Color( 0, 0.39, 0, 1 )


# basic actor class
class Actor:
	extends GNode
	
	func _init(graph_utils, name, neighbours, position).(graph_utils, name, neighbours, position):
		self.type.append("Actor")
		self.color = Color( 1, 0.55, 0, 1 )
	
