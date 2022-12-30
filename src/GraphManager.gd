extends Node2D

# imports
const graphNodes = preload("res://src/GraphNodes.gd")
const graphEdges = preload("res://src/GraphEdges.gd")

var nodes_dict = {
	"GNode": graphNodes.GNode,
	"Place": graphNodes.Place,
	"Actor": graphNodes.Actor,
}

var edges_dict = {
	"GEdge": graphEdges.GEdge,
	"WeightedEdge" : graphEdges.WeightedEdge
}

# functions
func load_test_graph():
	# make new graph
	make_new_graph("Test Graph", false)

	# root node
	var root_node = nodes_dict["GNode"].new()
	root_node.name = "root"
	root_node.position = Vector2(0,0)
	GlobalVariables.current_graph.add_node(root_node)
	
	# add world
	var world_node = nodes_dict["Place"].new()
	world_node.name = "world"
	world_node.position = Vector2(100,0)
	GlobalVariables.current_graph.add_node(world_node)
	
	var world_root_edge = edges_dict["GEdge"].new()
	GlobalVariables.current_graph.add_edge(
		world_root_edge,
		world_node,
		root_node
	)

	# add actors
	var adam = nodes_dict["Actor"].new()
	adam.name = "adam"
	adam.position = Vector2(50, 100)
	GlobalVariables.current_graph.add_node(adam)
	
	var adam_world_edge = edges_dict["GEdge"].new()
	GlobalVariables.current_graph.add_edge(
		adam_world_edge,
		adam,
		world_node
	)
	
	var eve = nodes_dict["Actor"].new()
	eve.name = "eve"
	eve.position = Vector2(150, 100)
	GlobalVariables.current_graph.add_node(eve)
	
	var eve_world_edge = edges_dict["GEdge"].new()
	GlobalVariables.current_graph.add_edge(
		eve_world_edge,
		eve,
		world_node
	)
	
	var eve_adam_edge = edges_dict["GEdge"].new()
	GlobalVariables.current_graph.add_edge(
		eve_adam_edge,
		eve,
		adam
	)
	
	GlobalVariables.current_graph.draw_edges()

# make new graph and select it
func make_new_graph(name : String, directed: bool = false):
	var new_graph = $TemplateGraph.duplicate()
	new_graph.name = name
	new_graph.directed = directed
	
	new_graph.visible = true
	$CurrentGraph.add_child(new_graph)
	
	GlobalVariables.current_graph = new_graph

