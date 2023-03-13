extends Node2D
class_name GraphManager

# node settings + properties
var nodeSettings = preload("res://resources/Nodes/node_settings.tres")
var edgeSettings = preload("res://resources/Edges/edge_settings.tres")

var graphs = {}
var selectedGraph = null

func _ready():
#	load_test_graph2()
	load_test_graph1()
	
func create_node(type : Array):
	# find the node type template
	var subDict = $Types.nodeTypes
	var nodeType = null
	for subType in type:
		if not subType in subDict.keys():
			print("Not a known node type: ", subType)
			return
		
		if subDict[subType][1] == null or subType == type[-1]:
			nodeType = subDict[subType][0]
		else:
			subDict = subDict[subType][1]

	# create node
	var newNode = nodeType.duplicate()
	newNode.settings = nodeSettings
	newNode.visible = true
	
	return newNode

func create_node_with_properties(properties : NodePropertiesResource):
	var newNode = create_node(properties.type)
	newNode.properties = properties
	newNode.update_from_properties()
	return newNode

func create_edge(type : Array):
	# find the edge type template
	var subDict = $Types.edgeTypes
	var edgeType = null
	for subType in type:
		if not subType in subDict.keys():
			print("Not a known edge type: ", subType)
			return
		
		if subDict[subType][1] == null or subType == type[-1]:
			edgeType = subDict[subType][0]
		else:
			subDict = subDict[subType][1]

	# create edge
	var newEdge = edgeType.duplicate()
	newEdge.settings = edgeSettings
	
	return newEdge

func create_edge_with_properties(properties : EdgePropertiesResource):
	var newEdge = create_edge(properties.type)
	newEdge.properties = properties
	return newEdge

func create_graph(type : Array):
	# find the edge type template
	var subDict = $Types.graphTypes
	var graphType = null
	for subType in type:
		if not subType in subDict.keys():
			print("Not a known graph type: ", subType)
			return
		
		if subDict[subType][1] == null or subType == type[-1]:
			graphType = subDict[subType][0]
		else:
			subDict = subDict[subType][1]
	
	# create graph
	var newGraph = graphType.duplicate()
	newGraph.visible = true
	
	return newGraph

func create_graph_with_properties(properties : GraphPropertiesResource):
	var newGraph = create_graph(properties.type)
	newGraph.properties = properties
	newGraph.update_from_properties()
	return newGraph

# make new graph and select it
func add_graph(graph):
	$Graphs.add_child(graph)
	graphs[graph.properties.name] = graph
	selectedGraph = graph
	hightlight_selected_graph()

# functions
func load_test_graph1():
	print("load_test_graph1")
	# make new graph
	var testGraph = create_graph(["Base", "Weighted"])
	testGraph.properties = GraphPropertiesResource.new()
	testGraph.properties.name = "Test Weighted Graph"
	testGraph.properties.type = ["Base", "Weighted"]
	testGraph.properties.directed = false
	testGraph.update_from_properties()
	
	# add nodes + edges
	var paradiseNode = create_node(["Base", "Place"])
	paradiseNode.properties = NodePropertiesResource.new()
	paradiseNode.properties.name = "Paradise"
	paradiseNode.properties.type = ["Base", "Place"]
	paradiseNode.properties.position = Vector2(0, 0)
	paradiseNode.update_from_properties()
	testGraph.add_node(paradiseNode)
	
	var adamNode = create_node(["Base", "Actor"])
	adamNode.properties = NodePropertiesResource.new()
	adamNode.properties.name = "Adam"
	adamNode.properties.type = ["Base", "Actor"]
	adamNode.properties.position = Vector2(100, 100)
	adamNode.update_from_properties()
	testGraph.add_node(adamNode)
	
	var adamParadiseEdge = create_edge(["Base", "Weighted"])
	adamParadiseEdge.properties = EdgePropertiesResource.new()
	adamParadiseEdge.properties.type = ["Base", "Weighted"]
	adamParadiseEdge.properties.weight = 0.6
	testGraph.add_edge(adamParadiseEdge, adamNode, paradiseNode)
	
	var eveNode = create_node(["Base", "Actor"])
	eveNode.properties = NodePropertiesResource.new()
	eveNode.properties.name = "Eve"
	eveNode.properties.type = ["Base", "Actor"]
	eveNode.properties.position = Vector2(100, -100)
	eveNode.update_from_properties()
	testGraph.add_node(eveNode)
	
	var eveParadiseEdge = create_edge(["Base", "Weighted"])
	eveParadiseEdge.properties = EdgePropertiesResource.new()
	eveParadiseEdge.properties.type = ["Base", "Weighted"]
	eveParadiseEdge.properties.weight = 0.5
	testGraph.add_edge(eveParadiseEdge, eveNode, paradiseNode)
	
	var eveAdamEdge = create_edge(["Base", "Weighted"])
	eveAdamEdge.properties = EdgePropertiesResource.new()
	eveAdamEdge.properties.type = ["Base", "Weighted"]
	eveAdamEdge.properties.weight = 1.0
	testGraph.add_edge(eveAdamEdge, eveNode, adamNode)
	
	var snakeNode = create_node(["Base", "Actor"])
	snakeNode.properties = NodePropertiesResource.new()
	snakeNode.properties.name = "Snake"
	snakeNode.properties.type = ["Base", "Actor"]
	snakeNode.properties.position = Vector2(200, 0)
	snakeNode.update_from_properties()
	testGraph.add_node(snakeNode)
	
	var snakeAdamEdge = create_edge(["Base", "Weighted"])
	snakeAdamEdge.properties = EdgePropertiesResource.new()
	snakeAdamEdge.properties.type = ["Base", "Weighted"]
	snakeAdamEdge.properties.weight = -1.0
	testGraph.add_edge(snakeAdamEdge, snakeNode, adamNode)
	
	var snakeEveEdge = create_edge(["Base", "Weighted"])
	snakeEveEdge.properties = EdgePropertiesResource.new()
	snakeEveEdge.properties.type = ["Base", "Weighted"]
	snakeEveEdge.properties.weight = -0.5
	testGraph.add_edge(snakeEveEdge, snakeNode, eveNode)
	
	add_graph(testGraph)
	testGraph.queue_redraw()


func load_test_graph2():
	# make new graph
	var testGraph = create_graph(["Base", "Weighted"])
	testGraph.properties = GraphPropertiesResource.new()
	testGraph.properties.name = "Test Weighted Graph"
	testGraph.properties.type = ["Base", "Weighted"]
	testGraph.properties.directed = false
	testGraph.update_from_properties()
	
	var rootNode = create_node(["Base", "Root"])
	rootNode.properties = NodePropertiesResource.new()
	rootNode.properties.name = "Root"
	rootNode.properties.type = ["Base", "Root"]
	rootNode.properties.position = Vector2(0, 0)
	rootNode.update_from_properties()
	testGraph.add_node(rootNode)
	
	var worldNode = create_node(["Base", "Place"])
	worldNode.properties = NodePropertiesResource.new()
	worldNode.properties.name = "World"
	worldNode.properties.type = ["Base", "Place"]
	worldNode.properties.position = Vector2(0, -100)
	worldNode.update_from_properties()
	testGraph.add_node(worldNode)
	
	var rootWorldEdge = create_edge(["Base", "Weighted"])
	rootWorldEdge.properties = EdgePropertiesResource.new()
	rootWorldEdge.properties.type = ["Base", "Weighted"]
	rootWorldEdge.properties.weight = 0.0
	testGraph.add_edge(rootWorldEdge, worldNode, rootNode)
	
	add_graph(testGraph)
	testGraph.queue_redraw()

func show_all_graphs():
	for graphName in graphs:
		graphs[graphName].show_all_nodes()
		graphs[graphName].show_all_edges()

func dim_all_graphs():
	for graphName in graphs:
		graphs[graphName].dim_all_nodes()
		graphs[graphName].dim_all_edges()

func hightlight_selected_graph():
	dim_all_graphs()
	
	if selectedGraph == null:
		return
	
	selectedGraph.show_all_nodes()
	selectedGraph.show_all_edges()

func save_graph(graph, graphDirPath : String):
	# remove if directory already exists
#	var directory = DirAccess.new()
	if graphDirPath[-1] != "/":
		graphDirPath += "/"
	if DirAccess.dir_exists_absolute(graphDirPath):
		DirAccess.remove_absolute(graphDirPath)
	DirAccess.make_dir_recursive_absolute(graphDirPath)
	
	# save nodes
	var nodeDirPath = graphDirPath + "nodes/"
	DirAccess.make_dir_absolute(nodeDirPath)
	
	var nodePaths = []
	for nodeIdx in graph.nodes.size():
		var nodePath = nodeDirPath + str(nodeIdx) + ".tres"
		graph.nodes[nodeIdx].update_to_properties()
		ResourceSaver.save(nodePath, graph.nodes[nodeIdx].properties)
		nodePaths.append(nodePath)
	graph.properties.nodePaths = nodePaths
	
	# save edges
	var edgeDirPath = graphDirPath + "edges/"
	DirAccess.make_dir_absolute(edgeDirPath)
	
	var edgePaths = []
	for edgeIdx in graph.edges.size():
		var edgePath = edgeDirPath + str(edgeIdx) + ".tres"
		ResourceSaver.save(edgePath, graph.edges[edgeIdx].properties)
		edgePaths.append(edgePath)
	graph.properties.edgePaths = edgePaths
	
	# save graph
	var graphPath = graphDirPath + "graph.tres"
	graph.update_to_properties()
	print(graph.properties.name)
	ResourceSaver.save(graphPath, graph.properties)

func load_graph(graphDirPath : String):
#	var directory = Directory.new()
	if graphDirPath[-1] != "/":
		graphDirPath += "/"
	if not DirAccess.dir_exists_absolute(graphDirPath):
		print("Not a directory: ", graphDirPath)
		return
	
	# load graph
	var graphPath = graphDirPath + "graph.tres"
	var graphProperties = load(graphPath)
	print(graphProperties.name)
	var loadedGraph = create_graph_with_properties(graphProperties)

	# load nodes
	for nodePath in graphProperties.nodePaths:
		var nodeProperties = load(nodePath)
		var loadedNode = create_node_with_properties(nodeProperties)
		loadedGraph.get_node("Nodes").add_child(loadedNode)
		loadedGraph.nodes.append(loadedNode)
	
	# load edges
	for edgePath in graphProperties.edgePaths:
		var edgeProperties = load(edgePath)
		var loadedEdge = create_edge_with_properties(edgeProperties)
		loadedGraph.get_node("Edges").add_child(loadedEdge)
		loadedGraph.edges.append(loadedEdge)
	
	add_graph(loadedGraph)
	loadedGraph.queue_redraw()

func save_project(projectDirPath : String):
	# remove if directory already exists
#	var directory = Directory.new()
	if projectDirPath[-1] != "/":
		projectDirPath += "/"
	if DirAccess.dir_exists_absolute(projectDirPath):
		DirAccess.remove_absolute(projectDirPath)
		print("remove: ", projectDirPath)
	DirAccess.make_dir_recursive_absolute(projectDirPath)
	
	# save graphs
	for graphName in graphs:
		var graphDirPath = projectDirPath + graphName + "/"
		save_graph(graphs[graphName], graphDirPath)

func load_project(projectDirPath : String):
	# remove if directory already exists
#	var directory = Directory.new()
	if projectDirPath[-1] != "/":
		projectDirPath += "/"
	if not DirAccess.dir_exists_absolute(projectDirPath):
		print("Directory doesn't exist: ", projectDirPath)
	var directory = DirAccess.open(projectDirPath)
	
	# delete old graphs
	var graphsToDelete = []
	for graphName in graphs:
		graphs[graphName].queue_free()
	graphs = {}
	
	# loop through saved graphs
	directory.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	
	var graphsLeft = true
	while graphsLeft:
		var graphName = directory.get_next()
		
		if graphName == "":
			break
		var graphDirPath = projectDirPath + graphName
		load_graph(graphDirPath)

func new_project():
	for graphName in graphs:
		graphs[graphName].queue_free()
	graphs = {}
	selectedGraph = null
