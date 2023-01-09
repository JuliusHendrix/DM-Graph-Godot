extends Node2D

var graphs = {}
var selected_graph = null

# functions
func load_test_graph1():
	# make new graph
	var test_graph = add_graph("test graph 1", false)

	# root node
	var root_node = $Types/Nodes/Root.duplicate()
	test_graph.add_node(root_node)
	root_node.set_name("root")
	root_node.position = Vector2(0,0)
	root_node.visible = true
	
	
	# add world
	var world_node = $Types/Nodes/Place.duplicate()
	test_graph.add_node(world_node)
	world_node.set_name("world")
	world_node.position = Vector2(100,0)
	world_node.visible = true
	
	
	var world_root_edge = $Types/Edges/BaseEdge.duplicate()
	test_graph.add_edge(
		world_root_edge,
		world_node,
		root_node
	)

	# add actors
	var adam_node = $Types/Nodes/Actor.duplicate()
	test_graph.add_node(adam_node)
	adam_node.set_name("adam")
	adam_node.position = Vector2(50, 100)
	adam_node.visible = true

	var adam_world_edge = $Types/Edges/BaseEdge.duplicate()
	test_graph.add_edge(
		adam_world_edge,
		adam_node,
		world_node
	)

	var eve_node = $Types/Nodes/Actor.duplicate()
	test_graph.add_node(eve_node)
	eve_node.set_name("eve")
	eve_node.position = Vector2(150, 100)
	eve_node.visible = true

	var eve_world_edge = $Types/Edges/BaseEdge.duplicate()
	test_graph.add_edge(
		eve_world_edge,
		eve_node,
		world_node
	)

	var eve_adam_edge = $Types/Edges/BaseEdge.duplicate()
	test_graph.add_edge(
		eve_adam_edge,
		eve_node,
		adam_node
	)
	
	test_graph.draw_edges()

func load_test_graph2():
	var test_graph = add_graph("test graph 2", false)
	
	# root node
	var root_node = $Types/Nodes/Root.duplicate()
	test_graph.add_node(root_node)
	root_node.set_name("root")
	root_node.position = Vector2(-100,0)
	root_node.visible = true
	
	
	# add world
	var world_node = $Types/Nodes/Place.duplicate()
	test_graph.add_node(world_node)
	world_node.set_name("world")
	world_node.position = Vector2(-200,0)
	world_node.visible = true
	
	
	var world_root_edge = $Types/Edges/BaseEdge.duplicate()
	test_graph.add_edge(
		world_root_edge,
		world_node,
		root_node
	)
	
	test_graph.draw_edges()

func show_all_graphs():
	for graphName in graphs:
		graphs[graphName].show_all_nodes()
		graphs[graphName].show_all_edges()

func dim_all_graphs():
	for graphName in graphs:
		graphs[graphName].dim_all_nodes()
		graphs[graphName].dim_all_edges()

func hightlight_selected_graph():
	if selected_graph == null:
		dim_all_graphs()
		return
	
	for graphName in graphs:
		if graphs[graphName] == selected_graph:
			graphs[graphName].show_all_nodes()
			graphs[graphName].show_all_edges()
		else:
			graphs[graphName].dim_all_nodes()
			graphs[graphName].dim_all_edges()

# make new graph and select it
func add_graph(name : String, directed: bool = false):
	var new_graph = $Types/Graphs/BaseGraph.duplicate()
	new_graph.name = name
	new_graph.directed = directed
	
	new_graph.visible = true
	$Graphs.add_child(new_graph)
	
	graphs[name] = new_graph
	selected_graph = new_graph
	hightlight_selected_graph()
	
	return new_graph

