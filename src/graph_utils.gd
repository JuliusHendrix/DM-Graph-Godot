# imports
const gc = preload("res://src/graph_classes.gd")

# trackables
var current_tool = 'select'
var graph : gc.Graph = gc.Graph.new("Test Graph")
var saved_graphs : Array = []
var selected_gnode = null
var above_gnode = null

# godot nodes to place nodes/edges into
var nodes_gdnode : Node
var edges_gdnode : Node


# CLASS DICTIONARIES


var node_type_dict = {
	"GNode": gc.GNode,
	"Place": gc.Place,
	"Actor": gc.Actor,
}

var edge_type_dict = {
	"GEdge": gc.GEdge,
}


# FUNCTIONS
# make new graph and select it
func new_graph(graph_name : String):
	graph = gc.Graph.new(graph_name)

func save_graph():
	if not graph in saved_graphs:
		saved_graphs.append(graph)

func load_graph(name : String):
	for _graph in saved_graphs:
		if _graph.name == name:
			graph = _graph
			
			# TODO: remove current nodes + edges from godot nodes GNodes and GEdges
			
			# TODO: add loaded nodes + edges to godot nodes GNodes and GEdges
			return
	
	print('Graph ' + name + 'not found.')

# find a node idx by its name
func find_gnode(node_name : String, type : String):
	for node in graph.nodes:
		if node.type[-1] == type:
			if node.name == node_name:
				return node

# add a node and the correspondig edges
func add_gnode(
	name : String,
	type : String = "GNode",
	position : Vector2 = Vector2(0,0),
	neighbours : Array = []) -> void:

	# check if node already exists
	if find_gnode(name, type) != null:
		print('node already added!')
		return
	
	# TODO: how to pass different init params? -> call_v
	# https://docs.godotengine.org/en/3.0/classes/class_object.html#class-object-callv
	var new_node = node_type_dict[type].new(self, name, neighbours, position)
	graph.nodes.append(new_node)
	nodes_gdnode.add_child(new_node)
	
	# add edges
	for neighbour in neighbours:
		var new_edge = gc.GEdge.new(new_node, neighbour)
		new_node.edges.append(new_edge)
		neighbour.edges.append(new_edge)
		graph.edges.append(new_edge)
		edges_gdnode.add_child(new_edge)


# find all edges connecting to a node
func find_connecting_edges(gnode : gc.GNode) -> Array:
	var sending = []
	var receiving = []
	
	for edge in graph.edges:
		if edge.sender == gnode:
			sending.append(edge)
		elif edge.receiver == gnode:
			receiving.append(edge)
	
	return [sending, receiving]

func set_selected_gnode(gnode : gc.GNode):
	if current_tool == 'select':
		selected_gnode = gnode

func clear_selected_gnode():
	if current_tool == 'select':
		selected_gnode = null

func move_gnode(pos : Vector2):
	if selected_gnode:
		selected_gnode.position = pos
		for edge in selected_gnode.edges:
			edge.update()
	

