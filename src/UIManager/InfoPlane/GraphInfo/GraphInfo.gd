extends Panel

var graph = null

func display_graph_info(graph):
	# set name
	$Contents/Name.text = graph.name
	
	# display type
	var typeString = ""
	for type in graph.properties.type:
		typeString += "/"
		typeString += type
	$Contents/Type.text = typeString
	
	$Contents/TabContainer/Nodes.clear_entries()
	for node in graph.nodes:
		$Contents/TabContainer/Nodes.add_entry(node)
	
	self.graph = graph

func update():
	var requested_node = $Contents/TabContainer/Nodes.get_requested()
	if requested_node != null:
		graph.select_node(requested_node)
	
