extends Panel

var node = null
var graph = null
var selectedNode = null

func _ready():
	# forward save function
	$Contents/TabContainer/Notes.saveNotesFunc = funcref(self, "save_notes")

func display_node_info(node, graph):
	if node == null:
		return

	# set name
	$Contents/Name.text = node.properties.name
	
	# display type
	var typeString = ""
	for type in node.properties.type:
		typeString += "/"
		typeString += type
	$Contents/Type.text = typeString
	
	# display connections
	$Contents/TabContainer/Connections.clear_entries()
	for neighbour in graph.get_node_neighbours(node):
		$Contents/TabContainer/Connections.add_entry(neighbour)
	
	# display notes
	$Contents/TabContainer/Notes.text = node.properties.notes
	
	self.node = node
	self.graph = graph

func save_notes(notes : String):
	node.properties.notes = notes

func update():
	if graph != null:
		var requested_node = $Contents/TabContainer/Connections.get_requested()
		if requested_node != null:
			graph.select_node(requested_node)
		
		if graph.selected_node != selectedNode:
			selectedNode = graph.selected_node
			display_node_info(selectedNode, graph)
	
