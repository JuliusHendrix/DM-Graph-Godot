extends Panel

var graph = null
var selectedNode = null

func display_graph_info(graph):
	# set name
	$OverviewContainer/Name.text = graph.name
	
	# display type
	var typeString = ""
	for type in graph.graphType:
		typeString += "/"
		typeString += type
	$OverviewContainer/Type.text = typeString
	
	$TabContainer/Nodes.clear_entries()
	for node in graph.nodes:
		$TabContainer/Nodes.add_entry(node)
	
	self.graph = graph

func update():
	var requested_node = $TabContainer/Nodes.get_requested()
	if requested_node != null:
		graph.set_selected_node(requested_node)
		selectedNode = requested_node
	
