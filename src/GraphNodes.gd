# node base class
class GNode:
	extends Area2D
	
	# utility parameters
	var mouse_over_prev = false
	var mouse_over = false
	var child_node
	var texture : Texture = load("res://images/root.png")
	
	# node parameters
	var type : Array = ["GNode"]

	func _ready():
		# instantiate template node
		child_node = get_parent().get_node("TemplateGraphNode").duplicate()
		child_node.visible = true
		child_node.get_node("LabelName").text = name
		child_node.get_node("Sprite").texture = texture
		self.add_child(child_node)
		
		# setup mouse click detection
		child_node.connect("mouse_entered", self, "_mouse_over", [true])
		child_node.connect("mouse_exited", self, "_mouse_over", [false])

	# track over which node we are hovering
	func _mouse_over(value):
		self.mouse_over_prev = self.mouse_over
		self.mouse_over = value

		if self.mouse_over_prev == false and self.mouse_over == true:
			GlobalVariables.above_gnode = self
		elif self.mouse_over_prev == true and self.mouse_over == false:
			GlobalVariables.above_gnode = null
		
		set_process_unhandled_input(true)

# basic place class
class Place:
	extends GNode
	
	func _init():
		self.type.append("Place")
		self.texture = load("res://images/place.png")


# basic actor class
class Actor:
	extends GNode
	
	func _init():
		self.type.append("Actor")
		self.texture = load("res://images/person.png")
